-- Bootstrap lazy.nvim
-- if vim.g.nix == true then
-- 	vim.opt.runtimepath:prepend([[lazy.nvim-plugin-path]])
-- else
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
	end
end
vim.opt.runtimepath:prepend(lazypath)
-- end

-- Shorthand for require"plugins"..module
local function configs(module)
	return function()
		require("plugins." .. module)
	end
end

-- Plugins
require("lazy").setup({
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = configs("treesitter"),
		dependencies = {
			{ "windwp/nvim-ts-autotag" },
			{ "nvim-treesitter/nvim-treesitter-textobjects" },
			{ "JoosepAlviste/nvim-ts-context-commentstring" },
			{ "nvim-treesitter/playground" },
		},
	},
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-fzy-native.nvim" },
		},
		config = configs("telescope"),
	}, -- Telescope

	{
		"VonHeikemen/lsp-zero.nvim",
		config = configs("lsp"),
		branch = "v3.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{
				"williamboman/mason.nvim",
				config = configs("mason"),
				cond = not vim.g.nix,
			},
			{
				"williamboman/mason-lspconfig.nvim",
				cond = not vim.g.nix,
			},

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "jc-doyle/cmp-pandoc-references" },
			{ "f3fora/cmp-spell" },
			{ "kdheepak/cmp-latex-symbols" },
			-- { "tzachar/cmp-tabnine", build = "nix-shell -p unzip --run './install.sh'" },
			{ "lukas-reineke/cmp-under-comparator" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },

			-- Customization
			{ "onsails/lspkind-nvim" },
			{
				"SmiteshP/nvim-navic",
				config = configs("navic"),
			},
			{
				"j-hui/fidget.nvim",
				tag = "legacy",
				event = "LspAttach",
				opts = { text = { spinner = "dots" } },
			},

			-- QOL
			{
				"nvimdev/lspsaga.nvim",
				config = configs("lspsaga"),
				dependencies = {
					"nvim-treesitter/nvim-treesitter",
					"nvim-tree/nvim-web-devicons",
				},
			},
		},
	},
	{
		"folke/trouble.nvim",
		config = configs("trouble"),
		dependencies = { "nvim-tree/nvim-web-devicons" },
	}, -- Diagnostics management
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
			{ "MunifTanjim/nui.nvim" },
			{ "s1n7ax/nvim-window-picker", config = configs("window-picker") },
		},
	}, -- Explorer
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-neo-tree/neo-tree.nvim" },
		},
	},
	{
		"mfussenegger/nvim-dap",
		config = configs("dap"),
		dependencies = {
			{ "mxsdev/nvim-dap-vscode-js" }, -- JS DAP
			{
				"microsoft/vscode-js-debug",
				build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
			}, -- JS DAP adapter
			{ "mfussenegger/nvim-dap-python" }, -- Python DAP
			{ "theHamsta/nvim-dap-virtual-text" }, -- DAP virtual text
		},
	}, -- Debug Adapter protocol
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			{ "mfussenegger/nvim-dap" },
			{ "nvim-neotest/nvim-nio" },
		},
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		dependencies = {
			{ "nvim-telescope/telescope.nvim" },
			{ "mfussenegger/nvim-dap" },
		},
	}, -- Telescope DAP plugin
	{
		"WhoIsSethDaniel/toggle-lsp-diagnostics.nvim",
		dependencies = {
			{ "neovim/nvim-lspconfig" },
		},
	},
	{
		"stevearc/conform.nvim",
		config = configs("formatting"),
	}, -- Formatting
	{
		"MunifTanjim/exrc.nvim",
		config = configs("exrc"),
		dependencies = { "MunifTanjim/nui.nvim" },
	}, -- Project local settings

	--- Language specific
	{ "vim-pandoc/vim-pandoc", lazy = false }, -- Pandoc integration
	{
		"vim-pandoc/vim-rmarkdown",
		dependencies = {
			{ "vim-pandoc/vim-pandoc" },
			{ "vim-pandoc-syntax" },
		},
		lazy = false,
	}, -- Pandoc filetype
	-- {
	-- 	"simrat39/rust-tools.nvim",
	-- 	config = configs("rust-tools"),
	-- 	dependencies = { { "VonHeikemen/lsp-zero.nvim" } },
	-- }, TODO: replace with rustacean.nvim
	{ "luckasRanarison/tree-sitter-hypr" },
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { { "nvim-lua/plenary.nvim" }, { "neovim/nvim-lspconfig" } },
		config = function()
			require("typescript-tools").setup({
				on_attach = require("plugins/lsp").on_attach,
			})
		end,
	},

	--- Git
	{ "tpope/vim-fugitive" }, -- Git integration
	{ "lewis6991/gitsigns.nvim", config = configs("gitsigns") }, -- Git changes in gutter

	--- Syntax
	{ "vim-pandoc/vim-pandoc-syntax", lazy = false }, -- Pandoc syntax
	{ "lervag/vimtex", lazy = false }, -- LaTeX syntax
	{ "elkowar/yuck.vim", lazy = false },
	{ "tjvr/vim-nearley", lazy = false },

	--- Shortcuts
	{ "kylechui/nvim-surround", config = true }, -- Edit surrounding text
	{ "tpope/vim-eunuch" }, -- Sugar on top of shell commands
	{ "monaqa/dial.nvim" }, -- Extended inc/decrement

	--- QOL
	{ "yuttie/comfortable-motion.vim" }, -- Smooth scrolling
	{ "numToStr/Comment.nvim", config = configs("comment") }, -- Comment out text
	{ "goolord/alpha-nvim", config = configs("greeter") }, -- Start screen
	{ "Shatur/neovim-session-manager", config = configs("sessions") }, -- Sessions
	{ "folke/which-key.nvim", config = configs("which-key") },
	{ "tpope/vim-repeat" }, -- Repeat
	{ "windwp/nvim-autopairs", event = "InsertEnter", config = configs("autopairs") }, -- Auto pair brackets
	{ "RRethy/nvim-treesitter-endwise" }, -- Endwise
	{ "Pocco81/auto-save.nvim", config = configs("autosave") }, -- Auto save

	--- Look & Feel
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = configs("hlchunk"),
	}, -- highlighting chunks & indent lines.
	{ "lambdalisue/nerdfont.vim" }, -- Nerdfont handler for vim
	{ "xiyaowong/nvim-transparent", config = configs("transparent") }, -- Enable terminal transparency.
	{ "ghifarit53/tokyonight-vim", config = configs("tokyonight") }, -- tokyonight theme
	{ "rebelot/kanagawa.nvim" }, -- kanagawa theme
	{ "catppuccin/nvim", name = "catppuccin" }, -- catppuccin theme
	{ "nyoom-engineering/oxocarbon.nvim" }, -- oxocarbon theme
	{ "bluz71/vim-moonfly-colors" }, -- moonfly theme
	{ "bluz71/vim-nightfly-colors" }, -- nightfly theme
	{ "raddari/last-color.nvim", config = configs("last-color") }, -- Remember colorscheme
	{
		"nvim-lualine/lualine.nvim",
		config = configs("lualine"),
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
	}, -- Statusline

	--- Tools
	{ "skywind3000/asyncrun.vim" }, -- Run shell commands in async
	{ "metakirby5/codi.vim" }, -- Code playground
	{ "mbbill/undotree" }, -- View undo tree
	{ "rcarriga/nvim-notify", config = configs("notify") }, -- Popup notify
	{ "uga-rosa/ccc.nvim", config = configs("ccc") }, --- Color picker and highlighter
}, {
	ui = {
		border = vim.g.borderstyle,
	},
	performance = {
		resetpackpath = false,
		rtp = { reset = false },
	},
})
