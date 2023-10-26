require"lspsaga".setup {
  ui = {
    border = vim.g.borderstyle,
    lines = { '╰', '├', '│', '─', '╭' },
  },
  rename = {
    keys = {
      select = "<Space>",
    },
  },
  symbol_in_winbar = {
    enable = false,
  },
  lightbulb = {
    enable = false
  },
  code_action = {
    extend_gitsigns = true,
  },
}
