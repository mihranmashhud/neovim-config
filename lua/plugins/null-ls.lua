local null_ls = require"null-ls"

null_ls.setup{
  sources = {
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.formatting.prettier.with({
      filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "css",
        "scss",
        "less",
        "html",
        "json",
        "jsonc",
        "yaml",
        "markdown",
        "graphql",
        "handlebars",
        "svelte",
      },
    }),
    null_ls.builtins.formatting.bibclean,
    null_ls.builtins.formatting.lua_format.with({
      extra_args = { "--indent-width=2", "--tab-width=2" },
    }),
  },
  on_attach = function(client)
    if client.server_capabilities.documentFormattingProvider then
      vim.keymap.set("n", "<space>lF", vim.lsp.buf.format,
                     { silent = true, desc = "Format file" })
    end
    if client.server_capabilities.documentRangeFormattingProvider then
      vim.keymap.set("v", "<space>lF", vim.lsp.buf.format,
                     { silent = true, desc = "Format file" })
    end
  end,
}
