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
  sign_icons = { error = " ", warn = " ", hint = " ", info = " " },
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
  vim.keymap.set("n", "K", vim.lsp.buf.hover,
                 { silent = true, desc = "Hover doc" })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition,
                 { silent = true, desc = "Go to definition" })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
                 { silent = true, desc = "Go to declaration" })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
                 { silent = true, desc = "Go to implementation" })
  vim.keymap.set("n", "go", vim.lsp.buf.definition,
                 { silent = true, desc = "Go to definition" })
  vim.keymap.set("n", "gr", vim.lsp.buf.references,
                 { silent = true, desc = "Go to references" })
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help,
                 { silent = true, desc = "Show signature help" })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next,
                 { silent = true, desc = "Prev diagnostic" })
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev,
                 { silent = true, desc = "Next diagnostic" })
  -- Leader mappings
  set_group_name("<leader>l", "LSP")
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename,
                 { silent = true, desc = "Rename" })
  vim.keymap.set("n", "<leader>le", vim.diagnostic.open_float,
                 { silent = true, desc = "View line diagnostics" })
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action,
                 { silent = true, desc = "View code actions" })
  vim.keymap.set("n", "<leader>lD", ":ToggleDiag<CR>",
                 { silent = true, desc = "Toggle diagnostics" })
end

lsp.on_attach(on_attach)

lsp.nvim_workspace()

lsp.setup()

-- Completion
local tabnine = require"cmp_tabnine.config"

tabnine:setup({
  max_lines = 1000,
  max_num_results = 20,
  sort = true,
  run_on_every_keystroke = true,
  snippet_placeholder = "..",
})

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and
           vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col)
             :match("%s") == nil
end

local cmp = require"cmp"
local luasnip = require("luasnip")
local cmp_autopairs = require"nvim-autopairs.completion.cmp"

cmp.setup(lsp.defaults.cmp_config({
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  completion = { completeopt = "menu,menuone,noselect" },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "buffer", keyword_length = 5 },
    { name = "cmp_tabnine" },
    { name = "path" },
    { name = "spell", keyword_length = 3 },
    { name = "calc" },
    { name = "pandoc_references" },
    { name = "latex_symbols", option = { strategy = 2 } },
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      require"cmp-under-comparator".under,
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
  experimental = { ghost_text = true },
  window = {
    documentation = cmp.config.window.bordered(),
    completion = cmp.config.window.bordered(),
  },
}))

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
