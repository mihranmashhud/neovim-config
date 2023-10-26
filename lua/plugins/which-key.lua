local wk = require"which-key"
wk.setup{
  window = { border = vim.g.borderstyle },
  spelling = { enabled = true, suggestions = 20 },
  disable = { buftypes = {}, filetypes = { "TelescopePrompt" } },
}
local group_names = require"general.keymap".group_names
for lhs, name in pairs(group_names) do wk.register{ [lhs] = { name = name } } end
