vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

local parser_install_dir = vim.fn.stdpath("cache").."/treesitters"
vim.fn.mkdir(parser_install_dir, "p")
vim.opt.runtimepath:append(parser_install_dir)

require"nvim-treesitter.configs".setup{
  parser_install_dir = parser_install_dir,
  ensure_installed = {
    "bash",
    "bibtex",
    "c",
    "cmake",
    "comment",
    "cpp",
    "css",
    "dart",
    "dockerfile",
    "graphql",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "julia",
    "latex",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "r",
    "rasi",
    "regex",
    "ruby",
    "rust",
    "scss",
    "svelte",
    "tsx",
    "toml",
    "typescript",
    "vim",
    "vue",
    "yaml",
  },
  highlight = { enable = true },
  autotag = { enable = true },
  endwise = { enable = true },
  indent = { enable = true },
  -- context_commentstring = { enable = true, enable_autocmd = false },
  playground = { enable = true },
}

require"ts_context_commentstring".setup{}

local parser_config = require"nvim-treesitter.parsers".get_parser_configs()
parser_config.hypr = {
  install_info = {
    url = "https://github.com/luckasRanarison/tree-sitter-hypr",
    files = { "src/parser.c" },
    branch = "master",
  },
  filetype = "hypr",
}
