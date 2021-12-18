local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local packer_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  packer_bootstrap = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local function configs(module)
  return string.format('require("configs.%s")', module)
end

require'packer'.startup {
  function(use)
    use {'wbthomason/packer.nvim'}

    --- LSP / IDE features
    use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = configs'nvim-treesitter',
    } -- Treesitter
    use {
      'windwp/nvim-ts-autotag',
      requires = {'nvim-treesitter/nvim-treesitter'}
    }
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        {'nvim-lua/popup.nvim'},
        {'nvim-lua/plenary.nvim'},
        {'nvim-telescope/telescope-fzy-native.nvim'},
      },
      config = configs'telescope',
    } -- Telescope
    use {
      'hrsh7th/nvim-cmp',
      requires = {{'L3MON4D3/LuaSnip'}},
      config = configs'completion',
    } -- Completion
    use {
      'neovim/nvim-lspconfig',
      config = configs'nvim-lsp',
    } -- LSP configs
    use {
      'onsails/lspkind-nvim',
      requires = {{'neovim/nvim-lspconfig'}}
    } -- LSP symbols
    use {
      'hrsh7th/cmp-nvim-lsp',
      requires = {{'hrsh7th/nvim-cmp'}, {'neovim/nvim-lspconfig'}}
    } -- LSP completion
    use {
      'hrsh7th/cmp-path',
      requires = {{'hrsh7th/nvim-cmp'}}
    } -- Path completion
    use {
      'hrsh7th/cmp-buffer',
      requires = {{'hrsh7th/nvim-cmp'}}
    } -- Buffer words completion
    use {
      'hrsh7th/cmp-cmdline',
      requires = {{'hrsh7th/nvim-cmp'}}
    } -- Completion in cmdline
    use {
      'tzachar/cmp-tabnine',
      run = './install.sh',
      requires = {{'hrsh7th/nvim-cmp'}}
    } -- Tabnine completion
    use {
      'lukas-reineke/cmp-under-comparator',
      requires = {{'hrsh7th/nvim-cmp'}}
    } -- underscore comparator for better sort order
    use {
      'hrsh7th/cmp-nvim-lua',
      requires = {{'hrsh7th/nvim-cmp'}}
    } -- Neovim Lua API completion
    use {
      'f3fora/cmp-spell',
      requires = {{'hrsh7th/nvim-cmp'}}
    } -- Spell completion
    use {
      'hrsh7th/cmp-calc',
      requires = {{'hrsh7th/nvim-cmp'}}
    } -- Calculation completion
    use {
      'kdheepak/cmp-latex-symbols',
      requires = {{'hrsh7th/nvim-cmp'}}
    } -- LaTeX Symbol completion
    use {
      'jc-doyle/cmp-pandoc-references',
      requires = {{'hrsh7th/nvim-cmp'}}
    } -- Pandoc citation references completion
    use 'L3MON4D3/LuaSnip' -- Snippet engine
    use {
      'saadparwaiz1/cmp_luasnip',
      requires = {{'hrsh7th/nvim-cmp'}, {'L3MON4D3/LuaSnip'}},
    } -- Snippet completion
    use {
      'folke/trouble.nvim',
      config = function() require'configs.trouble' end,
      requires = "kyazdani42/nvim-web-devicons",
    } -- Diagnostics management
    use 'liuchengxu/vista.vim' -- Tag viewer
    use {
      'tami5/lspsaga.nvim',
      config = configs'saga',
    } -- LSP UI
    use {
      'kyazdani42/nvim-tree.lua',
      requires = {{'kyazdani42/nvim-web-devicons'}},
      config = configs'nvim-tree',
    } -- Explorer
    use {
      'mfussenegger/nvim-dap',
      config = configs'nvim-dap',
    } -- Debug Adapter protocol
    use {
      'nvim-telescope/telescope-dap.nvim',
      requires = {
        {'nvim-telescope/telescope.nvim'},
        {'mfussenegger/nvim-dap'},
      },
    } -- Telescope DAP plugin
    use {
      'mfussenegger/nvim-dap-python',
      requires = {{'mfussenegger/nvim-dap'}},
    } -- Python DAP
    use {
      'theHamsta/nvim-dap-virtual-text',
      requires = {{'mfussenegger/nvim-dap'}},
    } -- DAP virtual text
    use {
      'chipsenkbeil/distant.nvim',
      config = configs'distant',
    }
    use {
      'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim',
      requires = {'neovim/nvim-lspconfig'},
    }

    --- Language specific
    use {'vim-pandoc/vim-pandoc', ft = {'pandoc', 'rmd'}, opt = true} -- Pandoc integration
    use {'JuliaEditorSupport/julia-vim', ft = {'julia'}, opt = true} -- Julia support in vim
    use {'alx741/vim-stylishask'} -- Prettify Haskell
    use {'jalvesaq/Nvim-R', branch = 'stable', ft= {'r'}, opt = true} -- R editing support
    use {
      'vim-pandoc/vim-rmarkdown',
      requires = {{'vim-pandoc/vim-pandoc'}, {'vim-pandoc-syntax'}},
      ft = {'rmd'}
    } -- Pandoc filetype

    --- Git
    use {'tpope/vim-fugitive'} -- Git integration
    use {
      'airblade/vim-gitgutter',
      config = configs'gitgutter',
    } -- Git changes in gutter

    --- Syntax
    use {'vim-pandoc/vim-pandoc-syntax', ft = {'pandoc', 'rmd'}} -- Pandoc syntax
    use {
      'sheerun/vim-polyglot',
      config = configs'polyglot',
    } -- Multilang syntax support
    use {'lervag/vimtex', ft = {'tex', 'latex'}} -- Latex syntax - used by pandoc syntax
    use {
      'evanleck/vim-svelte',
      branch = 'main',
      ft = {'svelte'},
      config = configs'vim-svelte',
    } -- svelte plugin
    use {
      'PProvost/vim-markdown-jekyll',
      ft = {'markdown', 'pandoc', 'rmarkdown'}
    } -- YAML front matter highlighting

    local prose_fts = {'markdown', 'pandoc', 'latex', 'mkd'}
    local prose_run = function () require'configs.writing' end
    --- Prose editing
    use {
      'reedes/vim-pencil',
      ft = prose_fts,
      run = prose_run,
    } -- Writing mode for vim
    use {
      'reedes/vim-litecorrect',
      ft = prose_fts,
      run = prose_run,
    } -- Autocorrect common spelling errors
    use {
      'reedes/vim-lexical',
      ft = prose_fts,
      run = prose_run,
    } -- Spell check additions + Thesaurus/dictionary completion
    use {
      'joom/latex-unicoder.vim',
      ft = prose_fts,
      run = prose_run,
      config = configs'latex-unicoder',
    } -- Convert latex command to unicode
    use {
      'dhruvasagar/vim-table-mode',
      ft = prose_fts,
      run = prose_run,
    } -- Mode for creating and editing tables

    --- Shortcuts
    use {'vim-scripts/BufOnly.vim'} -- Remove all buffers except current focused
    use {'blackCauldron7/surround.nvim'} -- Edit surrounding text
    use {'tpope/vim-eunuch'} -- Sugar on top of shell commands
    use {'monaqa/dial.nvim'} -- Extended inc/decrement

    --- QOL
    use {'yuttie/comfortable-motion.vim'} -- Smooth scrolling
    use {
      'b3nj5m1n/kommentary',
      config = configs'kommentary'
    } -- Comment out text
    use {'norcalli/nvim-colorizer.lua'} -- Fast color preview
    use {
      'goolord/alpha-nvim',
      config = configs'greeter',
    } -- Start screen
    use {
      'Shatur/neovim-session-manager',
      config = configs'sessions'
    } -- Sessions
    use 'folke/twilight.nvim'
    use {
      "folke/which-key.nvim",
      config = configs'which-key',
    }
    use {'tpope/vim-repeat'} -- Repeat

    use {'junegunn/goyo.vim'} -- Zen mode
    use {
      'windwp/nvim-autopairs',
      config = configs'autopairs',
    } -- Auto pair brackets
    use {'godlygeek/tabular'} -- Align text easily

    --- Look & Feel
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = configs'indentline',
    } -- Indent lines
    use {'lambdalisue/nerdfont.vim'} -- Nerdfont handler for vim
    use {'kjwon15/vim-transparent'} -- Enable terminal transparency. ~ Remove if not needed
    use {'ghifarit53/tokyonight-vim'} -- Tokyonight theme
    use {
      'glepnir/galaxyline.nvim',
      branch = 'main',
      requires = {'kyazdani42/nvim-web-devicons'},
      config = 'require"theming.galaxyline"',
    } -- Statusline
    -- use {
    --   'seblj/nvim-tabline',
    --   requires = {'kyazdani42/nvim-web-devicons'},
    --   config = configs'tabline',
    -- } -- Tabline
    use {
      'rafcamlet/tabline-framework.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = configs'tabline',
    }
    use {
      'ngscheurich/iris.nvim',
    }

    --- Tools
    use {'vim-scripts/Vimball'} -- Make and unzip vimballs
    use {'skywind3000/asyncrun.vim'} -- Run shell commands in async
    use {'metakirby5/codi.vim'} -- Code playground
    use {'mbbill/undotree'} -- View undo tree
    use {
      'iamcco/markdown-preview.nvim',
      run = 'cd app && npm install',
      setup = function()
        vim.g.mkdp_filetyes = { "markdown", "rmd" }
      end,
      ft = { 'markdown', 'rmd' }
    } -- Preview markdown while it is written ~ Replace with pandoc
    use {
      'rcarriga/nvim-notify',
      config = configs'notify',
    } -- Popup notify

    --- Browser
    use {'raghur/vim-ghost', run = ':GhostInstall'} -- Send text between browser and nvim.
    use {
      'glacambre/firenvim',
      run = function ()
        vim.fn['firenvim#install'](0)
      end,
      opt = true,
    } -- Browser integration

    --- Workarounds
    use {'antoinemadec/FixCursorHold.nvim'} -- Fix Cursor Hold Issue (https://github.com/neovim/neovim/issues/12587)
    use {'vim-scripts/dbext.vim'} -- Allow for connecting to databases

    -- Bootstapping
    if packer_bootstrap then
      require'packer'.sync()
    end
  end,
  config = {
    display = {
      open_fn = require'packer.util'.float,
    }
  }
}
