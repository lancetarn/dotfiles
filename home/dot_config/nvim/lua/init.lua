-- nvim-treesitter `main` branch config.
--
-- The `master` branch's `require'nvim-treesitter.configs'.setup{}` API is gone:
-- the rewrite installs parsers imperatively and leaves highlighting to Neovim
-- core (`vim.treesitter.start()`), so `highlight.enable`/`auto_install` no
-- longer exist.

-- Parsers to keep installed. `install()` is async and skips parsers that are
-- already present, so it's cheap to run on every startup. Add languages here
-- as needed, then restart (or `:TSInstall <lang>`).
require("nvim-treesitter").install({
  "c",
  "lua",
  "python",
  "rust",
  "go",
  "ruby",
  "elixir",
  "eex",
  "heex",
  "javascript",
  "typescript",
  "vue",
  "json",
  "yaml",
  "html",
  "markdown",
  "markdown_inline",
  "bash",
  "terraform",
  "clojure",
})

-- Turn on treesitter highlighting for any buffer whose filetype has a parser
-- installed. The pcall makes this a no-op for filetypes without one (this is
-- the `main`-branch replacement for the old `auto_install` convenience).
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
  callback = function()
    pcall(vim.treesitter.start)
  end,
})
