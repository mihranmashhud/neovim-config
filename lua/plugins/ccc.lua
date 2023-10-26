local ccc = require"ccc"
ccc.setup {
  win_opts = {
    border = vim.g.borderstyle,
  },
  inputs = {
    ccc.input.hsl,
    ccc.input.rgb,
    ccc.input.cmyk,
  },
  highlighter = {
    auto_enable = true,
  },
}
