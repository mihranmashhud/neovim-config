local alpha = require'alpha'
local dashboard = require'alpha.themes.dashboard'
dashboard.section.header.val = {
   [[⠀⠀⠀⢀⣴⣧⠀⠀⠀⠀⠀⠀⠀⠀⠀⣦⡀   ]],
   [[⠀⢀⣴⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣦⡀ ]],
   [[⣴⣌⢻⣿⣿⣿⣿⣿⣄⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣦]],
   [[⣿⣿⣦⠹⣿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿]],
   [[⣿⣿⣿⣷⡘⢿⣿⣿⣿⣿⣷⡀⠀⠀⠀⣿⣿⣿⣿⣿]],
   [[⣿⣿⣿⣿⣿⠈⢿⣿⣿⣿⣿⣿⣄⠀⠀⣿⣿⣿⣿⣿]],
   [[⣿⣿⣿⣿⣿⠀⠀⠻⣿⣿⣿⣿⣿⣦⠀⣿⣿⣿⣿⣿]],
   [[⣿⣿⣿⣿⣿⠀⠀⠀⠙⣿⣿⣿⣿⣿⣷⡙⣿⣿⣿⣿]],
   [[⣿⣿⣿⣿⣿⠀⠀⠀⠀⠈⢿⣿⣿⣿⣿⣷⡌⢿⣿⣿]],
   [[⢿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠻⣿⣿⣿⣿⣿⣆⠻⡿]],
   [[⠀⠙⢿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠙⣿⣿⣿⣿⡿⠃ ]],
   [[⠀⠀⠀⠙⢿⠀⠀⠀⠀⠀⠀⠀⠀⠈⢿⡿⠋   ]],
}
dashboard.section.buttons.val = {
   dashboard.button("SPC S L", " Last session", ":LoadCurrentDirSession<CR>"),
   dashboard.button("SPC f  ", " Find files", ":Telescope find_files<CR>"),
   dashboard.button("SPC s w", " Live grep", ":Telescope live_grep<CR>"),
   dashboard.button("SPC s h", " Search history", ":Telescope search_history<CR>"),
}

local handle = io.popen('fortune')
local fortune = handle:read("*a")
handle:close()
dashboard.section.footer.val = fortune

alpha.setup(dashboard.opts)
