vim.opt.autoindent = true -- Indent always
vim.opt.autoread = true -- Autoread file changes
vim.opt.background = "dark" -- Keep dark if it ain't transparent
vim.opt.clipboard = "unnamedplus" -- Use system clipboard
vim.opt.cmdheight = 0 -- Cmdline height
vim.opt.completeopt = { "menu", "menuone", "noselect" } -- Better completion experience
vim.opt.conceallevel = 0 -- Don't conceal things please
vim.opt.cursorline = true -- That line is important, the one the cursor is on
vim.opt.encoding = "utf-8" -- Use UTF-8 encoding
vim.opt.expandtab = true -- Tabs are actually spaces
vim.opt.fileencoding = "utf-8" -- UTF-8 encoding written to file
vim.opt.fillchars = { eob = " " } -- Transparent end of buffer chars
vim.opt.foldlevel = 99 -- Default to no folding
vim.opt.guifont = "Input Mono:h10" -- GUI Font
vim.opt.guifontwide = "FiraCode Nerd Font:h10" -- GUI Font
vim.opt.hidden = true -- Abandoning buffer does not unload it
vim.opt.hlsearch = true -- Persist that highlight
vim.opt.incsearch = true -- Highlight search
vim.opt.iskeyword = vim.opt.iskeyword + { "-" } -- Dash seperated words are text objects
vim.opt.laststatus = 2 -- Show me that beautiful statusline
vim.opt.linespace = 1 --
vim.opt.modelines = 1 --
vim.opt.modelines = 1 -- For custom commands in the buffer
vim.opt.mouse = "a" -- Hey sometimes it is more intuitive
vim.opt.number = true -- Show the current line number
vim.opt.pumheight = 10 -- Pop Up Menu height is 10 lines
vim.opt.relativenumber = true -- Show distance from current line
vim.opt.ruler = false -- Statusline plugin can also handle that
vim.opt.scrolloff = 8 -- Keep this many lines above and below cursor
vim.opt.shiftwidth = 2 -- This many spaces per tab
vim.opt.showmode = false -- Statusline plugin can handle that
vim.opt.signcolumn = "auto:4" -- Gutter is visible only when required
vim.opt.softtabstop = 2 -- Again this many spaces per tab
vim.opt.spellfile = "./en.utf-8.add" -- Local Spellfile additions
vim.opt.spelllang = { "en_us" } -- Spell language
vim.opt.splitbelow = true -- Would be pretty annoying if it kept opening up top
vim.opt.splitright = true -- Also annoying if it opened left
vim.opt.tabstop = 2 -- Really use 2 spaces okay?
vim.opt.termguicolors = true -- Give me all the colors!
vim.opt.timeoutlen = 500 -- Faster timeout
vim.opt.undodir = vim.fn.getenv("HOME") .. "/.local/share/nvim/undodir" -- Where to place undo files
vim.opt.undofile = true -- Track those changes!
vim.opt.updatetime = 100 -- Faster completion
vim.opt.virtualedit = "onemore" -- It feels better
vim.opt.whichwrap = "<,>,h,l,[,]" -- Wrap the cursor around
vim.opt.wrap = false -- Do not wrap the text, it's ugly

vim.cmd("filetype plugin on") -- For filetype plugins of course

-- Some extra vars for use in configs
vim.g.borderstyle = "rounded"
