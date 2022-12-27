vim.g.tokyonight_transparent_background = 1
vim.g.tokyonight_style = 'night'

local theme = require'last-color'.recall() or 'kat.nvim'

vim.cmd(("colorscheme %s"):format(theme))

vim.cmd[[
highlight VertSplit ctermbg=None guibg=None
highlight EndOfBuffer ctermbg=None guibg=None

" Git gutter
highlight GitGutterAdd ctermfg=None guibg=None
highlight GitGutterChange ctermbg=None guibg=None
highlight GitGutterDelete ctermbg=None guibg=None
highlight GitGutterChangeDelete ctermbg=None guibg=None
highlight GitGutterAddLine ctermbg=None guibg=None
highlight GitGutterChangeLine ctermbg=None guibg=None
highlight GitGutterDeleteLine ctermbg=None guibg=None
highlight GitGutterChangeDeleteLine ctermbg=None guibg=None
highlight GitGutterAddInvisible ctermbg=None guibg=None
highlight GitGutterChangeInvisible ctermbg=None guibg=None
highlight GitGutterDeleteInvisible ctermbg=None guibg=None

" Pmenu
highlight Pmenu ctermbg=None guibg=None
]]

vim.api.nvim_command('hi StatusLine guibg='..(require'galaxyline.theme'.default.bg))
vim.api.nvim_set_hl(0, "TSGroup", { link = "@group"})
