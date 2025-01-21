local ensure_installed =
	{
		-- LSPs
		"pyright",
		"vimls",
		"ccls",
		"tsserver",
		"julials",
		"svelte",
		"vuels",
		"jdtls",
		"emmet_ls",
		"cssls",
		"stylelint_lsp",
		"tailwindcss",
		"yamlls",
		"nil",
		"ltex-ls",
		-- Tools
		"prettierd",
		"isort",
		"black",
	},

---@diagnostic disable-next-line: redundant-value
require("mason").setup({
   ui = {
      border = vim.g.borderstyle,
   },
})

local registry = require("mason-registry")

for _, pkg_name in ipairs(ensure_installed) do
	local ok, pkg = pcall(registry.get_package, pkg_name)
	if ok then
		if not pkg:is_installed() then
			pkg:install()
		end
	end
end
