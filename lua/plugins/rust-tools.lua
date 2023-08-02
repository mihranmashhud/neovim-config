local rt = require"rust-tools"
local default_on_attach = require"plugins.lsp".on_attach
local capabilities = require"plugins.lsp".capabilities

local function on_attach(client, bufnr)
  default_on_attach(client, bufnr)
  vim.keymap.set("n", "K", rt.hover_actions.hover_actions,
                 { silent = true, desc = "Hover actions", buffer = bufnr })
  vim.keymap.set("n", "<leader>la", rt.code_action_group.code_action_group,
                 { silent = true, desc = "Code actions", buffer = bufnr })
end

rt.setup{
  server = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
}
