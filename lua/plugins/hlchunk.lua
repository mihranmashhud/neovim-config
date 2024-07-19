local function HLtoHex(hl)
  return function() return vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(hl)), "fg", "gui") end
end
require("hlchunk").setup({
	chunk = {
		enable = true,
		style = {
			{
				fg = HLtoHex("Keyword")
      },
			{
        fg = HLtoHex("Error")
			},
		},
	},
	indent = {
		enable = true,
	},
})
