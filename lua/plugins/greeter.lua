local alpha = require"alpha"
local dashboard = require"alpha.themes.dashboard"
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
  dashboard.button("SPC S L", " Last session",
                   ":SessionManager load_current_dir_session<CR>"),
  dashboard.button("SPC f  ", " Find files", ":Telescope find_files<CR>"),
  dashboard.button("SPC s w", " Live grep", ":Telescope live_grep<CR>"),
  dashboard.button("SPC s h", " Search history",
                   ":Telescope search_history<CR>"),
}

dashboard.section.footer.val = "Code at the speed of thought."

alpha.setup(dashboard.opts)
