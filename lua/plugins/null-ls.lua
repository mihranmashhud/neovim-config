local null_ls = require"null-ls"

null_ls.setup{
  sources = {
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.formatting.prettier.with{
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
    },
    null_ls.builtins.formatting.bibclean,
    null_ls.builtins.formatting.lua_format.with{
      condition = function(utils)
        return utils.root_has_file({ ".lua-format" })
      end,
      extra_args = { "--config=.lua-format" },
    },
  },
}
