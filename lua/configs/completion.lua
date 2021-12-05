local tabnine = require'cmp_tabnine.config'
local cmp_autopairs = require'nvim-autopairs.completion.cmp'

tabnine:setup({
        max_lines = 1000;
        max_num_results = 20;
        sort = true;
        run_on_every_keystroke = true;
        snippet_placeholder = '..';
    })

local function has_words_before()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require("luasnip")
local cmp = require'cmp'

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char={tex=''}}))

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c'}),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
        ['<C-y>'] = cmp.config.disable,
        ['<C-e>'] = cmp.mapping({
                i = cmp.mapping.abort(),
                c = cmp.mapping.close(),
            }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
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
    },
    completion = {
        -- autocomplete = false,
        completeopt = 'menu,menuone,noselect',
    },
    sources = {
        { name = 'nvim_lsp'},
        { name = 'nvim_lua'},
        { name = 'luasnip'},
        { name = 'buffer', keyword_length = 5 },
        { name = 'cmp_tabnine' },
        { name = 'path' },
        { name = 'spell', keyword_length = 3 },
        { name = 'calc'},
        { name = 'pandoc_references'},
        { name = 'latex_symbols'},
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
    documentation = {
        border = 'rounded',
        maxwidth = 120,
        minwidth = 60,
        maxheight = math.floor(vim.o.lines * 0.3),
    },
    formatting = {
        format = require'lspkind'.cmp_format({
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
        native_menu = false,
        ghost_text = true,
    },
})

cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    },
})

cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
            { name = 'path' },
        }, {
            { name = 'cmdline' },
        })
})
