local lspconfig = require'lspconfig'
-- local protocol = require'vim.lsp.protocol'
local util = require'lspconfig.util'
local map_utils = require'utils.map'
local nmap = map_utils.nmap
local vmap = map_utils.vmap
-- local autocmd = require'utils.autocmd'.autocmd
local set_group_name = require('utils.map').set_group_name
local dirname = util.path.dirname

local on_attach = function(client)
  print('LSP started.')

  -- Mappings
  local opts = { noremap=true, silent=true }
  nmap('gd', vim.lsp.buf.definition, opts, 'Go to definition')
  nmap('gD', vim.lsp.buf.declaration, opts, 'Go to declaration')
  nmap('gr', vim.lsp.buf.references, opts, 'Go to references')
  nmap('gi', vim.lsp.buf.implementation, opts, 'Go to implementation')
  nmap('gs', vim.lsp.buf.signature_help, opts, 'Show signature help')
  nmap('K', ':Lspsaga hover_doc<CR>', opts, 'Hover doc')
  nmap(']d', vim.lsp.diagnostic.goto_next, opts, 'Prev diagnostic')
  nmap('[d', vim.lsp.diagnostic.goto_prev, opts, 'Next diagnostic')
  -- Leader mappings
  set_group_name('<leader>l', 'LSP')
  nmap('<leader>lr', ':Lspsaga rename<CR>', opts, 'Rename')
  nmap('<leader>le', ':Lspsaga show_line_diagnostics<CR>', opts, 'View line diagnostics')
  nmap('<leader>la', ':Lspsaga code_action<CR>', opts, 'View code actions')
  nmap('<leader>lD', ':ToggleDiag<CR>', opts, 'Toggle diagnostics')
end

local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Python
lspconfig.pyright.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Vim
lspconfig.vimls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

-- C++/C
lspconfig.ccls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  compilationDatabaseDirectory = "build";
  root_dir = function (fname)
    return util.root_pattern("compile_commands.json", "compile_flags.txt", ".git", ".ccls")(fname) or dirname(fname)
  end
}

-- Typescript
lspconfig.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Julia
lspconfig.julials.setup{
  on_new_config = function(new_config,_)
    local server_path = "/home/mihranmashhud/.julia/packages/LanguageServer/y1ebo/src"
    local cmd = {
      "julia",
      "--project="..server_path,
      "--startup-file=no",
      "--history-file=no",
      "-e", [[
      using Pkg;
      Pkg.instantiate()
      using LanguageServer; using SymbolServer;
      depot_path = get(ENV, "JULIA_DEPOT_PATH", "")
      project_path = dirname(something(Base.current_project(pwd()), Base.load_path_expand(LOAD_PATH[2])))
      # Make sure that we only load packages from this environment specifically.
      @info "Running language server" env=Base.load_path()[1] pwd() project_path depot_path
      server = LanguageServer.LanguageServerInstance(stdin, stdout, project_path, depot_path);
      server.runlinter = true;
      run(server);
      ]]
    };
    new_config.cmd = cmd
  end,
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Haskell
lspconfig.hls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Svelte
lspconfig.svelte.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Lua
local sumneko_linux_bin = false
local sumneko_linux_root = false
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
  sumneko_linux_bin = "/usr/bin/lua-language-server"
  sumneko_linux_root = "/usr/share/lua-language-server"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

local sumneko_root_path = sumneko_linux_root or vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_linux_bin or sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

lspconfig.sumneko_lua.setup {
  root_dir = function(fname)
    return util.find_git_ancestor(fname) or util.path.dirname(fname)
  end,
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          [vim.fn.expand('$HOME/.config/nvim/lua')] = true,
        },
      },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Ruby
lspconfig.solargraph.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Dart/Flutter
lspconfig.dartls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Java
lspconfig.java_language_server.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Emmet
lspconfig.emmet_ls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "css", "svelte" },
}

-- CSS
lspconfig.cssls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.stylelint_lsp.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.tailwindcss.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Diagnostics

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  signs = {
    severity = {
      min = vim.diagnostic.severity.WARN,
    },
  },
})
