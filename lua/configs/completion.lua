local autocmd = require'utils.autocmd'.autocmd
local t = require'utils.map'.t

vim.o.shortmess = vim.o.shortmess..'c' -- Avoid short message

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

local snippets = require'snippets'

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif snippets.has_active_snippet() then
    return t "<Plug>lua return require'snippets'.expand_or_advance(1)<CR>"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif snippets.has_active_snippet() then
    return t "<Plug>lua return require'snippets'.advance_snippet(-1)<CR>"
  else
    return t "<S-Tab>"
  end
end

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = 'rounded', -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };
  source = {
    buffer = true;
    calc = true;
    latex_symbols = true;
    nvim_lsp = true;
    nvim_lua = true;
    omni = true;
    path = true;
    snippets_nvim = true;
    spell = true;
    tabnine = true;
    tags = true;
  };
}
