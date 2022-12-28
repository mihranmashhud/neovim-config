-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data").."/lazy/lazy.nvim"
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
  return function()
    require("plugins."..module)
  end
end

local prose_fts = {"markdown", "pandoc", "latex", "mkd"}
local prose_run = function () require"plugins.writing" end

require"lazy".setup({
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = configs"nvim-treesitter",
    commit = "4cccb6f494eb255b32a290d37c35ca12584c74d0",
    dependencies = {
      "windwp/nvim-ts-autotag",
      "nvim-treesitter/nvim-treesitter-textobjects",
      "JoosepAlviste/nvim-ts-context-commentstring",
    }
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      {"nvim-lua/popup.nvim"},
      {"nvim-lua/plenary.nvim"},
      {"nvim-telescope/telescope-fzy-native.nvim"},
    },
    config = configs"telescope",
    version = "0.1.0",
  }, -- Telescope

  {
    "VonHeikemen/lsp-zero.nvim",
    config = configs"nvim-lsp",
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
      {
        "tzachar/cmp-tabnine",
        build = "./install.sh",
      },
      "lukas-reineke/cmp-under-comparator",

      -- Snippets
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",

      -- Customization
      "onsails/lspkind-nvim",
    }
  },
  {
    "folke/trouble.nvim",
    config = true,
    dependencies = "kyazdani42/nvim-web-devicons",
  }, -- Diagnostics management
  "liuchengxu/vista.vim", -- Tag viewer
  {
    "tami5/lspsaga.nvim",
    config = configs"saga",
  }, -- LSP UI
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {{"kyazdani42/nvim-web-devicons"}},
    config = configs"nvim-tree",
  }, -- Explorer
  {
    "mfussenegger/nvim-dap",
    config = configs"nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui", -- DAP UI
      "mxsdev/nvim-dap-vscode-js", -- JS DAP
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npm run compile",
      }, -- JS DAP adapter
      "mfussenegger/nvim-dap-python", -- Python DAP
      "theHamsta/nvim-dap-virtual-text", -- DAP virtual text
    }
  }, -- Debug Adapter protocol
  {
    "nvim-telescope/telescope-dap.nvim",
    dependencies = {
      {"nvim-telescope/telescope.nvim"},
      {"mfussenegger/nvim-dap"},
    },
  }, -- Telescope DAP plugin
  {
    "chipsenkbeil/distant.nvim",
    config = configs"distant",
  },
  {
    "WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
    dependencies = {"neovim/nvim-lspconfig"},
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = configs"null-ls",
    dependencies = {"nvim-lua/plenary.nvim"},
  }, -- Non-LSP sources
  {
    "MunifTanjim/exrc.nvim",
    dependencies = {"MunifTanjim/nui.nvim"},
  }, -- Project local settings.

  --- Language specific
  {"vim-pandoc/vim-pandoc", ft = {"pandoc", "rmd"}}, -- Pandoc integration
  {"alx741/vim-stylishask"}, -- Prettify Haskell
  {
    "jalvesaq/Nvim-R",
    branch = "stable",
  }, -- R editing support
  {
    "vim-pandoc/vim-rmarkdown",
    dependencies = {{"vim-pandoc/vim-pandoc"}, {"vim-pandoc-syntax"}},
    ft = {"rmd"}
  }, -- Pandoc filetype
  {"mfussenegger/nvim-jdtls"},

  --- Git
  {"tpope/vim-fugitive"}, -- Git integration
  {
    "airblade/vim-gitgutter",
    config = configs"gitgutter",
  }, -- Git changes in gutter

  --- Syntax
  {
    "vim-pandoc/vim-pandoc-syntax",
    lazy = false,
  }, -- Pandoc syntax
  {
    "lervag/vimtex",
    lazy = false,
  }, -- LaTeX syntax
  {
    "PProvost/vim-markdown-jekyll",
    lazy = false,
  }, -- YAML front matter highlighting
  {
    "elkowar/yuck.vim",
    lazy = false,
  },

  --- Prose editing
  {
    "reedes/vim-pencil",
    ft = prose_fts,
    run = prose_run,
  }, -- Writing mode for vim
  {
    "reedes/vim-litecorrect",
    ft = prose_fts,
    run = prose_run,
  }, -- Autocorrect common spelling errors
  {
    "reedes/vim-lexical",
    ft = prose_fts,
    run = prose_run,
  }, -- Spell check additions + Thesaurus/dictionary completion
  {
    "dhruvasagar/vim-table-mode",
    ft = prose_fts,
    run = prose_run,
  }, -- Mode for creating and editing tables

  --- Shortcuts
  {"vim-scripts/BufOnly.vim"}, -- Remove all buffers except current focd
  {
    "kylechui/nvim-surround",
    config = true,
  }, -- Edit surrounding text
  {"tpope/vim-eunuch"}, -- Sugar on top of shell commands
  {"monaqa/dial.nvim"}, -- Extended inc/decrement

  --- QOL
  {"yuttie/comfortable-motion.vim"}, -- Smooth scrolling
  {
    "numToStr/Comment.nvim",
    config = configs"comment",
  }, -- Comment out text
  {"norcalli/nvim-colorizer.lua"}, -- Fast color preview
  {
    "goolord/alpha-nvim",
    config = configs"greeter",
  }, -- Start screen
  {
    "Shatur/neovim-session-manager",
    config = configs"sessions"
  }, -- Sessions
  "folke/twilight.nvim",
  {
    "folke/which-key.nvim",
    config = configs"which-key",
  },
  {"tpope/vim-repeat"}, -- Repeat

  {"junegunn/goyo.vim"}, -- Zen mode
  {
    "windwp/nvim-autopairs",
    config = configs"autopairs",
  }, -- Auto pair brackets
  {"godlygeek/tabular"}, -- Align text easily

  --- Look & Feel
  {
    "lukas-reineke/indent-blankline.nvim",
    config = configs"indentline",
  }, -- Indent lines
  "lambdalisue/nerdfont.vim", -- Nerdfont handler for vim
  {
    "xiyaowong/nvim-transparent",
    config = configs"transparent",
  }, -- Enable terminal transparency.
  "ghifarit53/tokyonight-vim", -- Tokyonight theme
  "rebelot/kanagawa.nvim", -- kanagawa theme
  "raddari/last-color.nvim", -- Remember colorscheme
  {
    "SmiteshP/nvim-navic",
    config = function()
      require("nvim-navic").setup({ separator = " ", highlight = true, depth_limit = 5 })
    end,
    dependencies = "neovim/nvim-lspconfig",
    lazy = false,
  },
  {
    "nvim-lualine/lualine.nvim",
    config = configs"lualine",
    dependencies = { "kyazdani42/nvim-web-devicons" }
  },
  -- {
  --   "rafcamlet/tabline-framework.nvim",
  --   dependencies = "kyazdani42/nvim-web-devicons",
  --   config = configs"tabline",
  -- },
  "ngscheurich/iris.nvim",

  --- Tools
  "vim-scripts/Vimball", -- Make and unzip vimballs
  "skywind3000/asyncrun.vim", -- Run shell commands in async
  "metakirby5/codi.vim", -- Code playground
  "mbbill/undotree", -- View undo tree
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetyes = { "markdown", "rmd" }
    end,
    ft = { "markdown", "rmd" }
  }, -- Preview markdown while it is written ~ Replace with pandoc
  {
    "rcarriga/nvim-notify",
    config = configs"notify",
  }, -- Popup notify

  --- Browser
  {
    "subnut/nvim-ghost.nvim",
    run = {
      ":call nvim_ghost#installer#install()"
    }
  },

  "vim-scripts/dbext.vim", -- Allow for connecting to databases
})
