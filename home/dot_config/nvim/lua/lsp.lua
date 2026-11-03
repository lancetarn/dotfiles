-- Native LSP config (Neovim >= 0.11 `vim.lsp.config` API).
--
-- Why this file exists separately from coc.nvim: coc owns LSP for every other
-- language here (see coc-settings.json). Elixir is deliberately carved out and
-- served through Neovim's *built-in* LSP client instead, because
-- elixir-tools.nvim wires servers through native `vim.lsp` too. Two clients in
-- one buffer would double up completion, so Elixir stays out of coc's
-- `languageserver` block.
--
-- ------------------------------------------------------------------ why ----
-- Expert (https://expert-lsp.org) was tried here and reverted on 2026-09-10.
-- It completes the LSP handshake and advertises every capability, so it *looks*
-- healthy, but it never answers a request. Expert boots a per-project "engine"
-- node using the ERTS it ships in its own release (erts-15.2.7) rather than the
-- asdf Erlang the project builds against, and that node dies on startup:
--
--   [backend] Engine build script exited with status: 1
--   Runtime terminating during boot ({'cannot get bootfile', ...expert/bin...})
--
-- After which every request is answered with a log line and nothing else:
--
--   Received request textDocument/hover before engine for backend was
--   initialized. Ignoring.
--
-- Verified against userflow/backend (832 .ex files) and a smaller Phoenix app:
-- hover, documentSymbol and completion all returned null. Re-test with
-- `expert --stdio` before considering a switch back; the tell is whether
-- `.expert/project.log` ever logs "Compile completed".
--
-- ---------------------------------------------------------------- Dexter ----
-- Dexter (https://github.com/remoteoss/dexter, `brew install dexter-lsp`) is a
-- Go LSP over a SQLite index of the project, so it answers immediately and does
-- not need to boot a BEAM node against the project's Elixir. On userflow/backend
-- it hovers, completes and lists symbols in milliseconds off a warm index.
--
-- Two things to know about it:
--   * It picks its own project root by walking up to the git root, ignoring the
--     `rootUri` the client sends -- on the userflow monorepo it roots at the
--     repo top and writes its index to `.dexter/dexter.db`, not to backend/.
--     `root_markers` below therefore only decides *where nvim starts it*, and
--     `.git` is listed first to match what dexter picks anyway.
--   * It reports NO diagnostics. The capability is absent from its initialize
--     response, and a deliberate syntax error produced zero
--     publishDiagnostics on didChange or didSave. Navigation, completion, hover
--     and formatting work; compile errors do not appear in the gutter. Credo is
--     already a dep of userflow/backend if that gap needs filling later
--     (`credo = { enable = true }` in the elixir-tools block in plugins.lua).
-- Skipped on machines without dexter, so opening an Elixir file there doesn't
-- report a missing server.
if vim.fn.executable("dexter") == 1 then
  vim.lsp.config("dexter", {
    cmd = { "dexter", "lsp" },
    filetypes = { "elixir", "eelixir", "heex" },
    root_markers = { ".git", "mix.exs" },
  })

  vim.lsp.enable("dexter")
end

-- ------------------------------------------------------------ diagnostics ----
-- Only affects the native client (Elixir); coc renders its own diagnostics in a
-- separate namespace and is untouched by this. Note that dexter publishes none,
-- so today this styles diagnostics that only a future Elixir source would emit.
vim.diagnostic.config({
  virtual_text = { spacing = 2, prefix = "‹" },
  underline = true,
  severity_sort = true,
  float = { border = "rounded", source = true },
})

-- Neovim 0.11+ ships default LSP mappings on the `gr` prefix (grn/gra/grr/gri/
-- grt). Those make the bare `gr` this config has used for "references" since the
-- coc days ambiguous — nvim would sit and wait for `timeoutlen` on every press.
-- Drop the defaults so `gr` stays unambiguous; the equivalents are re-bound
-- per-buffer below with the same keys coc uses elsewhere.
for _, lhs in ipairs({ "grn", "gra", "grr", "gri", "grt" }) do
  pcall(vim.keymap.del, "n", lhs)
end

-- --------------------------------------------------------------- on attach ----
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("native_lsp_attach", { clear = true }),
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end

    -- Silence coc's completion popup in this buffer so there aren't two menus
    -- competing; native LSP completion (below) is the source of truth here.
    vim.b[bufnr].coc_suggest_disable = 1

    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
    end

    -- Mirror the coc keymaps from init.vim so muscle memory carries over.
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end

    map("n", "gd", vim.lsp.buf.definition, "LSP definition")
    map("n", "gy", vim.lsp.buf.type_definition, "LSP type definition")
    map("n", "gt", vim.lsp.buf.implementation, "LSP implementation")
    map("n", "gr", vim.lsp.buf.references, "LSP references")
    map("n", "<leader>rn", vim.lsp.buf.rename, "LSP rename")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP code action")
    map("n", "<leader>ds", vim.lsp.buf.document_symbol, "LSP document symbols")
    map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
    map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, "Next diagnostic")

    -- Format on save, matching what this config already does for Python
    -- (Black), Rust (rustfmt) and Terraform. Set `vim.g.lsp_format_on_save = 0`
    -- to opt out.
    if client:supports_method("textDocument/formatting") and vim.g.lsp_format_on_save ~= 0 then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("lsp_format_" .. bufnr, { clear = true }),
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, id = client.id, timeout_ms = 5000 })
        end,
      })
    end
  end,
})

-- --------------------------------------------------------------- commands ----
-- Dexter reindexes changed files in the background on startup and watches
-- `**/*.{ex,exs}`, so this is only for when the index visibly drifts -- after a
-- big rebase or a `mix deps.get` that rewrites deps out from under the watcher.
-- Unlike Expert's `Reindex`, dexter exposes no workspace/executeCommand for it
-- (its initialize response has no executeCommandProvider), so this shells out to
-- the same binary and then restarts the client to pick the new index up.
vim.api.nvim_create_user_command("DexterReindex", function()
  local root = vim.fs.root(0, { ".git", "mix.exs" }) or vim.fn.getcwd()
  vim.notify("dexter: reindexing " .. root .. " ...", vim.log.levels.INFO)
  vim.system({ "dexter", "reindex" }, { cwd = root, text = true }, function(out)
    vim.schedule(function()
      if out.code == 0 then
        vim.notify("dexter: reindex done", vim.log.levels.INFO)
      else
        vim.notify("dexter: reindex failed\n" .. (out.stderr or ""), vim.log.levels.ERROR)
      end
    end)
  end)
end, { desc = "Re-index the project with dexter" })
