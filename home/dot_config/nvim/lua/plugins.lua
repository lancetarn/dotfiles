-- Plugin spec for lazy.nvim (migrated from dein).
-- Bootstrap + require("lazy").setup(require("plugins")) happens in init.vim.
return {
  "5long/pytest-vim-compiler",
  { "digitaltoad/vim-pug", ft = "vue" },
  -- dein pinned branch "release", which no longer exists upstream; track default (master).
  "fatih/vim-go",
  "GCBallesteros/jupytext.vim",
  "godlygeek/tabular",
  "Glench/Vim-Jinja2-Syntax",
  "hashivim/vim-terraform",
  "honza/vim-snippets",
  { "junegunn/fzf", build = "./install --all" },
  { "junegunn/fzf.vim", dependencies = { "junegunn/fzf" } },
  -- Elixir tooling: `:Mix` with task completion, Phoenix alternate-file
  -- navigation, and the `:Elixir` command. Every language server it can manage
  -- is switched OFF on purpose — dexter serves Elixir through native LSP in
  -- lua/lsp.lua, and `elixirls.enable` defaults to *true* upstream (nil counts
  -- as enabled), so it has to be disabled explicitly or it downloads and runs
  -- ElixirLS alongside dexter.
  --
  -- `credo.enable` is the one worth revisiting: dexter reports no diagnostics
  -- at all, and credo is already a dep of userflow/backend, so flipping this to
  -- true is the cheapest way to get warnings back in the gutter.
  --
  -- projectionist only populates `g:projectionist_heuristics`, so tpope's
  -- vim-projectionist is what actually makes `:A`/`:Ealternate` work; plenary is
  -- a hard dependency of the plugin's utils module even with the servers off.
  {
    "elixir-tools/elixir-tools.nvim",
    version = "*",
    ft = { "elixir", "eelixir", "heex" },
    dependencies = { "nvim-lua/plenary.nvim", "tpope/vim-projectionist" },
    config = function()
      require("elixir").setup({
        elixirls = { enable = false },
        nextls = { enable = false },
        credo = { enable = false },
        projectionist = { enable = true },
      })
    end,
  },
  "justinmk/vim-sneak",
  "jparise/vim-graphql",
  { "luochen1990/rainbow", ft = "clojure" },
  "unblevable/quick-scope",
  { "kkoomen/vim-doge", build = ":call doge#install()" },
  "knsh14/vim-github-link",
  "majutsushi/tagbar",
  "manicmaniac/coconut.vim",
  { "neoclide/coc.nvim", branch = "release" },
  "sbdchd/neoformat",
  "slim-template/vim-slim",
  { "Olical/conjure", ft = "clojure" },
  { "Olical/aniseed", tag = "v3.18.0" },
  "Tsuzat/NeoSolarized.nvim",
  "shaunsingh/solarized.nvim",
  "ellisonleao/gruvbox.nvim",
  { "psf/black", branch = "stable" },
  { "pangloss/vim-javascript", ft = "javascript", commit = "db595656304959dcc3805cf63ea9a430e3f01e8f" },
  -- { "posva/vim-vue", ft = "vue" },
  "romainl/flattened",
  "rust-lang/rust.vim",
  "scrooloose/nerdtree",
  "scrooloose/syntastic",
  -- `main` branch (the rewrite). The old `master` branch is frozen and its
  -- highlighter breaks on Neovim 0.12 ("attempt to call method 'range'"); the
  -- new API lives in lua/init.lua.
  { "nvim-treesitter/nvim-treesitter", branch = "main", lazy = false, build = ":TSUpdate" },
  { "glacambre/firenvim", tag = "0.2.14", build = function() vim.fn["firenvim#install"](0) end },
  "tpope/vim-commentary",
  "tpope/vim-dispatch",
  "tpope/vim-eunuch",
  "tpope/vim-fugitive",
  "tpope/vim-surround",
  "vim-airline/vim-airline",
  -- dein pinned "v3.0", but iron.nvim publishes no tags; master is the current v3 API.
  "Vigemus/iron.nvim",
  "vmware-archive/salt-vim",
  "RRethy/base16-nvim",
}
