-- LSP configuration
local lsp = require"lsp-zero"
local lsp_capabilities = require"cmp_nvim_lsp".default_capabilities()
local lspconfig = require"lspconfig"

vim.diagnostic.config{
  virtual_text = false,
} -- Do this before lsp zero configuration

vim.g.lsp_zero_ui_float_border = vim.g.borderstyle

lsp.set_sign_icons{
  error = " ",
  warn = " ",
  hint = " ",
  info = " ",
}

local navic = require"nvim-navic"
local set_group_name = require"general.keymap".set_group_name

local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  -- Mappings
  vim.keymap.set("n", "K", function() require"lspsaga.hover":render_hover_doc{} end,
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
  vim.keymap.set("n", "]d", function() require"lspsaga.diagnostic":goto_prev() end,
                 { silent = true, desc = "Prev diagnostic" })
  vim.keymap.set("n", "[d", function() require"lspsaga.diagnostic":goto_next() end,
                 { silent = true, desc = "Next diagnostic" })
  -- Leader mappings
  set_group_name("<leader>l", "LSP")
  vim.keymap.set("n", "<leader>lr", function() require"lspsaga.rename":lsp_rename{"++project"} end,
                 { silent = true, desc = "Rename" })
  vim.keymap.set("n", "<leader>le", function() require"lspsaga.diagnostic.show":show_diagnostics{line = true} end,
                 { silent = true, desc = "View line diagnostics" })
  vim.keymap.set("n", "<leader>ld", function() require"lspsaga.diagnostic.show":show_diagnostics{cursor = true} end,
                 { silent = true, desc = "View cursor diagnostics" })
  vim.keymap.set("n", "<leader>la", function() require"lspsaga.codeaction":code_action() end,
                 { silent = true, desc = "View code actions" })
  vim.keymap.set("n", "<leader>lD", ":ToggleDiag<CR>",
                 { silent = true, desc = "Toggle diagnostics" })
  vim.keymap.set("n", "<space>lF", ":Format<CR>",
                 { silent = true, desc = "Format file" })
  vim.keymap.set("v", "<space>lF", ":Format<CR>",
                 { silent = true, desc = "Format file" })
end

lsp.on_attach(on_attach)

require"mason-lspconfig".setup {
  handlers = {
    lsp.default_setup,
  },
}

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
lspconfig.nixd.setup({on_attach = on_attach, capabilities = lsp_capabilities})

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

return {
  on_attach = on_attach,
  capabilities = lsp_capabilities,
}
