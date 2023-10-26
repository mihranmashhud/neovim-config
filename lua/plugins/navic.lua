local symbol_map = require"lspkind".symbol_map
for kind, icon in pairs(symbol_map) do
   symbol_map[kind] = icon.." "
end
require"nvim-navic".setup{
  separator = " › ",
  icons = symbol_map,
}
