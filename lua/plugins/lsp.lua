-- LSP configuration
local lsp = require"lsp-zero"

lsp.set_preferences{
  suggest_lsp_servers = true,
  setup_servers_on_start = true,
  set_lsp_keymaps = false,
  configure_diagnostics = true,
  cmp_capabilities = true,
  manage_nvim_cmp = false,
  call_servers = "local",
  sign_icons = {
    error = " ",
    warn = " ",
    hint = " ",
    info = " ",
  },
}

lsp.ensure_installed{
  "pyright",
  "vimls",
  "clangd",
  "tsserver",
  "julials",
  -- "hls",
  "svelte",
  "vuels",
  "sumneko_lua",
  "solargraph",
  "jdtls",
  "emmet_ls",
  "cssls",
  "stylelint_lsp",
  "tailwindcss",
  -- "r_language_server",
  "yamlls",
}

local navic = require"nvim-navic"
local set_group_name = require"general.keymap".set_group_name

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  print("LSP started.")

  -- Mappings
  vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>", { silent = true, desc = "Hover doc" })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true, desc = "Go to definition" })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { silent = true, desc = "Go to declaration" })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { silent = true, desc = "Go to implementation" })
  vim.keymap.set("n", "go", vim.lsp.buf.definition, { silent = true, desc = "Go to definition" })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true, desc = "Go to references" })
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, { silent = true, desc = "Show signature help" })
  vim.keymap.set("n", "]d", vim.lsp.diagnostic.goto_next, { silent = true, desc = "Prev diagnostic" })
  vim.keymap.set("n", "[d", vim.lsp.diagnostic.goto_prev, { silent = true, desc = "Next diagnostic" })
  -- Leader mappings
  set_group_name("<leader>l", "LSP")
  vim.keymap.set("n", "<leader>lr", ":Lspsaga rename<CR>", { silent = true, desc = "Rename" })
  vim.keymap.set("n", "<leader>le", ":Lspsaga show_line_diagnostics<CR>", { silent = true, desc = "View line diagnostics" })
  vim.keymap.set("n", "<leader>la", ":Lspsaga code_action<CR>", { silent = true, desc = "View code actions" })
  vim.keymap.set("n", "<leader>lD", ":ToggleDiag<CR>", { silent = true, desc = "Toggle diagnostics" })
end

lsp.on_attach(on_attach)

lsp.nvim_workspace()

lsp.setup()

-- Completion
local tabnine = require"cmp_tabnine.config"

tabnine:setup({
  max_lines = 1000;
  max_num_results = 20;
  sort = true;
  run_on_every_keystroke = true;
  snippet_placeholder = "..";
})

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require"cmp"
local luasnip = require("luasnip")
local cmp_autopairs = require"nvim-autopairs.completion.cmp"

cmp.setup(lsp.defaults.cmp_config({
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  completion = {
    completeopt = 'menu,menuone,noselect',
  },
  sources = {
    { name = "nvim_lsp"},
    { name = "nvim_lua"},
    { name = "luasnip"},
    { name = "buffer", keyword_length = 5 },
    { name = "cmp_tabnine" },
    { name = "path" },
    { name = "spell", keyword_length = 3 },
    { name = "calc"},
    { name = "pandoc_references"},
    { name = "latex_symbols", option = {
      strategy = 2,
    }},
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require "cmp-under-comparator".under,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  formatting = {
    format = require"lspkind".cmp_format({
      with_text = true,
      menu = {
        buffer = "[buffer]",
        nvim_lua = "[api]",
        nvim_lsp = "[lsp]",
        luasnip = "[snip]",
        cmp_tabnine = "[tn]",
        path = "[path]",
        calc = "[calc]",
        spell = "[spell]",
        pandoc_references = "[cite]",
        latex_symbols = "[symbols]",
      },
    }),
  },
  experimental = {
    ghost_text = true,
  },
  window = {
    documentation = cmp.config.window.bordered(),
    completion = cmp.config.window.bordered(),
  },
}))

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" }
  }
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" }
  }, {
      { name = "cmdline" }
    })
})

cmp.event:on(
  "confirm_done",
  cmp_autopairs.on_confirm_done()
)

-- local lspconfig = require"lspconfig"
-- -- local protocol = require"vim.lsp.protocol"
-- local util = require"lspconfig.util"
-- local map_utils = require"utils.map"
-- local nmap = map_utils.nmap
-- local vmap = map_utils.vmap
-- -- local autocmd = require"utils.autocmd".autocmd
-- local set_group_name = require("utils.map").set_group_name
-- local dirname = util.path.dirname


-- local capabilities = require"cmp_nvim_lsp".default_capabilities(vim.lsp.protocol.make_client_capabilities())

-- -- Python
-- lspconfig.pyright.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- -- Vim
-- lspconfig.vimls.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- -- C++/C
-- lspconfig.ccls.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
--   compilationDatabaseDirectory = "build";
--   root_dir = function (fname)
--     return util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".ccls")(fname) or dirname(fname)
--   end
-- }

-- -- Typescript
-- lspconfig.tsserver.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- -- Julia
-- lspconfig.julials.setup{
--   on_new_config = function(new_config,_)
--     local server_path = "/home/mihranmashhud/.julia/packages/LanguageServer/y1ebo/src"
--     local cmd = {
--       "julia",
--       "--project="..server_path,
--       "--startup-file=no",
--       "--history-file=no",
--       "-e", [[
--       using Pkg;
--       Pkg.instantiate()
--       using LanguageServer; using SymbolServer;
--       depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
--       project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
--       # Make sure that we only load packages from this environment specifically.
--       @info "Running language server" env=Base.load_path()[1] pwd() project_path depot_path
--       server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
--       server.runlinter = true;
--       run(server);
--       ]]
--     };
--     new_config.cmd = cmd
--   end,
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- -- Haskell
-- lspconfig.hls.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- -- Svelte
-- lspconfig.svelte.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- lspconfig.vuels.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- -- Lua
-- local sumneko_linux_bin = ""
-- local sumneko_linux_root = ""
-- local system_name
-- if vim.fn.has("mac") == 1 then
--   system_name = "macOS"
-- elseif vim.fn.has("unix") == 1 then
--   system_name = "Linux"
--   sumneko_linux_bin = "/usr/bin/lua-language-server"
--   sumneko_linux_root = "/usr/share/lua-language-server"
-- elseif vim.fn.has("win32") == 1 then
--   system_name = "Windows"
-- else
--   print("Unsupported system for sumneko")
-- end

-- local sumneko_root_path = sumneko_linux_root or vim.fn.stdpath("cache").."/lspconfig/sumneko_lua/lua-language-server"
-- local sumneko_binary = sumneko_linux_bin or sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

-- lspconfig.sumneko_lua.setup {
--   root_dir = function(fname)
--     return util.find_git_ancestor(fname) or util.path.dirname(fname)
--   end,
--   cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
--   settings = {
--     Lua = {
--       runtime = {
--         -- Tell the language server which version of Lua you"re using (most likely LuaJIT in the case of Neovim)
--         version = "LuaJIT",
--         -- Setup your lua path
--         path = vim.split(package.path, ";"),
--       },
--       diagnostics = {
--         -- Get the language server to recognize the `vim` global
--         globals = {"vim"},
--       },
--       workspace = {
--         -- Make the server aware of Neovim runtime files
--         library = {
--           [vim.fn.expand("$VIMRUNTIME/lua")] = true,
--           [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
--           [vim.fn.expand("$HOME/.config/nvim/lua")] = true,
--         },
--       },
--     },
--   },
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- -- Ruby
-- lspconfig.solargraph.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- -- Dart/Flutter
-- lspconfig.dartls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- -- Java
-- -- lspconfig.java_language_server.setup{
-- --   on_attach = on_attach,
-- --   capabilities = capabilities,
-- --   cmd = { "/usr/bin/java-language-server" },
-- -- }


-- -- Emmet
-- lspconfig.emmet_ls.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "html", "css", "svelte" },
-- }

-- -- CSS
-- lspconfig.cssls.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- lspconfig.stylelint_lsp.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- lspconfig.tailwindcss.setup{
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- Diagnostics

-- local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

-- for type, icon in pairs(signs) do
--   local hl = "DiagnosticSign" .. type
--   vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

-- vim.diagnostic.config({
--   signs = {
--     severity = {
--       min = vim.diagnostic.severity.WARN,
--     },
--   },
-- })

-- For use in other lsp configurations.
return {
  on_attach = on_attach
}
