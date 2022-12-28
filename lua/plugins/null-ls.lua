local map_utils = require 'utils.map'
local nmap = map_utils.nmap
local null_ls = require 'null-ls'

null_ls.setup {
  sources = {
    null_ls.builtins.code_actions.eslint, null_ls.builtins.diagnostics.eslint,

    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript", "javascriptreact", "typescript", "typescriptreact", "vue",
        "css", "scss", "less", "html", "json", "jsonc", "yaml", "markdown",
        "graphql", "handlebars", "svelte"
      }
    }), null_ls.builtins.formatting.bibclean,
    null_ls.builtins.formatting.lua_format.with({
      extra_args = {"--indent-width=2", "--tab-width=2"}
    })
  },
  on_attach = function(client)
    local opts = {noremap = true, silent = true}
    if client.server_capabilities.documentFormattingProvider then
      nmap('<space>lF', vim.lsp.buf.formatting, opts, 'Format file')
    elseif client.server_capabilities.documentRangeFormattingProvider then
      nmap('<space>lF', vim.lsp.buf.range_formatting, opts, 'Format file')
    end
  end
}
