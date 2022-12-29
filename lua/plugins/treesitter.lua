vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

require'nvim-treesitter.configs'.setup{
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
    "help",
    "html",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "julia",
    "latex",
    "lua",
    "make",
    "python",
    "r",
    "rasi",
    "regex",
    "ruby",
    "scss",
    "svelte",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
  },
  highlight = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  playground = {
    enable = true,
  }
}

