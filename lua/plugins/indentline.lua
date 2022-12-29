vim.g.indent_blankline_filetype_exclude = {
  "help",
  "alpha",
  "dashpreview",
  "NvimTree",
  "vista"
}
vim.g.indent_blankline_buftype_exclude = {"terminal"}
vim.g.indent_blankline_use_treesitter = false
vim.g.indent_blankline_char = ""
vim.g.indent_blankline_show_first_indent_level = false

require"indent_blankline".setup{}
