vim.g.tokyonight_transparent_background = 1
vim.g.tokyonight_style = "night"

local theme = require"last-color".recall() or "kat.nvim"

vim.cmd(("colorscheme %s"):format(theme))
vim.api.nvim_set_hl(0, "TSGroup", { link = "@group"})
