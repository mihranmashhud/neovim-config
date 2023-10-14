-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

local function configs(module)
  return function() require("plugins." .. module) end
end

local prose_fts = { "markdown", "pandoc", "latex", "mkd" }

-- Plugins
require"lazy".setup({
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = configs"treesitter",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
      -- "nvim-treesitter/playground",
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-lua/popup.nvim" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzy-native.nvim" },
    },
    config = configs"telescope",
    version = "0.1.0",
  }, -- Telescope

  {
    "VonHeikemen/lsp-zero.nvim",
    config = configs"lsp",
    dependencies = {
      -- LSP Support
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",

      -- Autocompletion
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "jc-doyle/cmp-pandoc-references",
      "f3fora/cmp-spell",
      "kdheepak/cmp-latex-symbols",
      { "tzachar/cmp-tabnine", build = "./install.sh" },
      "lukas-reineke/cmp-under-comparator",

      -- Snippets
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",

      -- Customization
      "onsails/lspkind-nvim",
      "SmiteshP/nvim-navic",
      {"j-hui/fidget.nvim", config = true},
    },
  },
  {
    "folke/trouble.nvim",
    config = configs"trouble",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  }, -- Diagnostics management
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      { "s1n7ax/nvim-window-picker", config = configs"window-picker" },
    },
  }, -- Explorer
  {
    "mfussenegger/nvim-dap",
    config = configs"dap",
    dependencies = {
      "rcarriga/nvim-dap-ui", -- DAP UI
      "mxsdev/nvim-dap-vscode-js", -- JS DAP
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npm run compile",
      }, -- JS DAP adapter
      "mfussenegger/nvim-dap-python", -- Python DAP
      "theHamsta/nvim-dap-virtual-text", -- DAP virtual text
    },
  }, -- Debug Adapter protocol
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = {
      { "nvim-telescope/telescope.nvim" },
      { "mfussenegger/nvim-dap" },
    },
  }, -- Telescope DAP plugin
  {
    "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "stevearc/conform.nvim",
    config = configs"formatting",
  },
  {
    "MunifTanjim/exrc.nvim",
    config = configs"exrc",
    dependencies = { "MunifTanjim/nui.nvim" },
  }, -- Project local settings.

  --- Language specific
  { "vim-pandoc/vim-pandoc", lazy = false }, -- Pandoc integration
  -- { "jalvesaq/Nvim-R", branch = "stable" }, -- R editing support
  {
    "vim-pandoc/vim-rmarkdown",
    dependencies = { "vim-pandoc/vim-pandoc", "vim-pandoc-syntax" },
    lazy = false,
  }, -- Pandoc filetype
  {
    "simrat39/rust-tools.nvim",
    config = configs"rust-tools",
    dependencies = { "VonHeikemen/lsp-zero.nvim" }
  },

  --- Git
  { "tpope/vim-fugitive" }, -- Git integration
  { "lewis6991/gitsigns.nvim", config = configs"gitsigns" }, -- Git changes in gutter

  --- Syntax
  { "vim-pandoc/vim-pandoc-syntax", lazy = false }, -- Pandoc syntax
  { "lervag/vimtex", lazy = false }, -- LaTeX syntax
  { "PProvost/vim-markdown-jekyll", lazy = false }, -- YAML front matter highlighting
  { "elkowar/yuck.vim", lazy = false },

  --- Prose editing
  {
    "reedes/vim-pencil",
    ft = prose_fts,
    config = configs"writing",
    dependencies = {
      "reedes/vim-litecorrect", -- Autocorrect common spelling errors
      "reedes/vim-lexical", -- Spell check additions + Thesaurus/dictionary completion
      "dhruvasagar/vim-table-mode", -- Mode for creating and editing tables
    },
  }, -- Writing mode for vim

  --- Shortcuts
  { "kylechui/nvim-surround", config = true }, -- Edit surrounding text
  { "tpope/vim-eunuch" }, -- Sugar on top of shell commands
  { "monaqa/dial.nvim" }, -- Extended inc/decrement

  --- QOL
  { "yuttie/comfortable-motion.vim" }, -- Smooth scrolling
  { "numToStr/Comment.nvim", config = configs"comment" }, -- Comment out text
  { "norcalli/nvim-colorizer.lua", config = configs"colorizer" }, -- Fast color preview
  { "goolord/alpha-nvim", config = configs"greeter" }, -- Start screen
  { "Shatur/neovim-session-manager", config = configs"sessions" }, -- Sessions
  { "folke/twilight.nvim" },
  { "folke/which-key.nvim", config = configs"which-key" },
  { "tpope/vim-repeat" }, -- Repeat
  { "folke/zen-mode.nvim", config = configs"zen-mode" }, -- Zen mode
  { "windwp/nvim-autopairs", config = configs"autopairs" }, -- Auto pair brackets
  { "godlygeek/tabular" }, -- Align text easily
  { "Pocco81/auto-save.nvim", config = configs"autosave" }, -- Auto save

  --- Look & Feel
  { "lukas-reineke/indent-blankline.nvim", config = configs"indentline" }, -- Indent lines
  "lambdalisue/nerdfont.vim", -- Nerdfont handler for vim
  { "xiyaowong/nvim-transparent", config = configs"transparent" }, -- Enable terminal transparency.
  { "ghifarit53/tokyonight-vim", config = configs"tokyonight" }, -- Tokyonight theme
  { "rebelot/kanagawa.nvim" }, -- kanagawa theme
  { "catppuccin/nvim", name = "catppuccin" }, -- catppuccin theme
  { "raddari/last-color.nvim", config = configs"last-color" }, -- Remember colorscheme
  {
    "SmiteshP/nvim-navic",
    config = configs"navic",
    dependencies = "neovim/nvim-lspconfig",
    lazy = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = configs"lualine",
    dependencies = { "kyazdani42/nvim-web-devicons" },
  },

  --- Tools
  { "skywind3000/asyncrun.vim" }, -- Run shell commands in async
  { "metakirby5/codi.vim" }, -- Code playground
  { "mbbill/undotree" }, -- View undo tree
  { "rcarriga/nvim-notify", config = configs"notify" }, -- Popup notify

  --- Browser
  -- { "subnut/nvim-ghost.nvim" },
}, {
    ui = {
      border = "rounded",
    },
  })
