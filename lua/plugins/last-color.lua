local theme = require"last-color".recall() or "kanagawa"
vim.cmd(("colorscheme %s"):format(theme))
