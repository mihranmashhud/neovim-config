local ensure_installed = {
  -- LSPs
  "pyright",
  "vimls",
  "clangd",
  "tsserver",
  "julials",
  "svelte",
  "vuels",
  "lua_ls",
  "jdtls",
  "emmet_ls",
  "cssls",
  "stylelint_lsp",
  "tailwindcss",
  "yamlls",
  "nil_ls",
  -- Tools
  "stylua",
  "prettierd",
  "isort",
  "black",
},
require"mason".setup{}

local registry = require"mason-registry"

for _, pkg_name in ipairs(ensure_installed) do
  local ok, pkg = pcall(registry.get_package, pkg_name)
  if ok then
    if not pkg:is_installed() then
       pkg:install()
    end
  end
end
