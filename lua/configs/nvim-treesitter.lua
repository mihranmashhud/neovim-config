vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

require'nvim-treesitter.configs'.setup{
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
}

