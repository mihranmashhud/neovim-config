local M = {}
M.group_names = {}
local function set_group_name(lhs, name)
  M.group_names[lhs] = name
end
M.set_group_name = set_group_name

-- Indentation mapping
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("i", "<C-j>", "(<C-n>)", { expr = true })
vim.keymap.set("i", "<C-k>", "(<C-p>)", { expr = true })
vim.keymap.set("n", "<C-j>", ":cnext<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", ":cprev<CR>", { silent = true })

vim.keymap.set("n", ";", ":")
vim.keymap.set("n", ":", ";")
vim.keymap.set("i", ";", ":")
vim.keymap.set("i", ":", ";")

-- Esc alias
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("t", "jk", "<Esc>")
vim.keymap.set("t", "kj", "<Esc>")

-- Move lines around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "Y", "y$") -- Capital Y does what it should
vim.keymap.set("n", "J", "mzJ`z") -- J does not move the cursor

-- Window resize
vim.keymap.set("n", "<M-j>", ":resize -2<CR>", { silent = true })
vim.keymap.set("n", "<M-k>", ":resize +2<CR>", { silent = true })
vim.keymap.set("n", "<M-h>", ":vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<M-l>", ":vertical resize +2<CR>", { silent = true })

-- Keep jumps centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Undo break points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", "!", "!<c-g>u")
vim.keymap.set("i", "?", "?<c-g>u")

-- Word count
vim.keymap.set("n", "<F3>", ":w !detex \\| wc -w<CR>")

-- Increment/Decrement
vim.keymap.set("n", "<C-a>", "<Plug>(dial-increment)")
vim.keymap.set("n", "<C-x>", "<Plug>(dial-decrement)")
vim.keymap.set("v", "<C-a>", "<Plug>(dial-increment)")
vim.keymap.set("v", "<C-x>", "<Plug>(dial-decrement)")
vim.keymap.set("v", "g<C-a>", "g<Plug>(dial-increment)")
vim.keymap.set("v", "g<C-x>", "g<Plug>(dial-decrement)")

-- WhichKey/Leader:
vim.g.mapleader = " "
vim.keymap.set("n", "<Space>", "")

vim.keymap.set("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { silent = true, desc = "comment" })
vim.keymap.set("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { silent = true, desc = "comment" })
vim.keymap.set("n", "<leader>;", ":Commands<CR>", { silent = true, desc = "commands" })
vim.keymap.set("n", "<leader>=", "<C-w>=", { silent = true, desc = "balance windows" })
vim.keymap.set("n", "<leader>,", ":Dashboard<CR>", { silent = true, desc = "start screen" })
vim.keymap.set("n", "<leader>c", ":Codi!!<CR>", { silent = true, desc = "live repl" })
vim.keymap.set("n", "<leader>f", ":Telescope find_files<CR>", { silent = true, desc = "files" })
vim.keymap.set("n", "<leader>z", ":Goyo<CR>", { silent = true, desc = "zen mode" })
vim.keymap.set("n", "<leader>h", ":noh<CR>", { silent = true, desc = "remove search highlight" })
vim.keymap.set("n", "<leader>q", ":bd<CR>", { silent = true, desc = "quit buffer" })
vim.keymap.set("n", "<leader>j", ":lnext<CR>", { silent = true, desc = "loc next" })
vim.keymap.set("n", "<leader>k", ":lprev<CR>", { silent = true, desc = "loc prev" })

set_group_name("<leader>a", "Actions")
vim.keymap.set("n", "<leader>ac", ":ColorizerToggle<CR>", { silent = true, desc = "colorizer" })
vim.keymap.set("n", "<leader>ae", ":NvimTreeToggle<CR>", { silent = true, desc = "explorer" })
vim.keymap.set("n", "<leader>au", ":UndotreeToggle<CR>", { silent = true, desc = "undo tree" })
vim.keymap.set("n", "<leader>an", ":DashboardNewFile<CR>", { silent = true, desc = "new file" })
vim.keymap.set("n", "<leader>at", ":Vista<CR>", { silent = true, desc = "view tags" })
vim.keymap.set("n", "<leader>aT", ":Twilight<CR>", { silent = true, desc = "twilight" })

set_group_name("<leader>s", "Search")
vim.keymap.set("n", "<leader>sh", ":Telescope search_history<CR>", { silent = true, desc = "search history" })
vim.keymap.set("n", "<leader>s;", ":Telescope commands<CR>", { silent = true, desc = "commands" })
vim.keymap.set("n", "<leader>sb", ":Telescope current_buffer_fuzzy_find<CR>", { silent = true, desc = "current buffer" })
vim.keymap.set("n", "<leader>sB", ":Telescope buffers<CR>", { silent = true, desc = "buffers" })
vim.keymap.set("n", "<leader>sc", ":Telescope git_commits<CR>", { silent = true, desc = "commits" })
vim.keymap.set("n", "<leader>sC", ":Telescope git_buffer_commits<CR>", { silent = true, desc = "buffer commits" })
vim.keymap.set("n", "<leader>sH", ":Telescope command_history<CR>", { silent = true, desc = "command history" })
vim.keymap.set("n", "<leader>sm", ":Telescope marks<CR>", { silent = true, desc = "marks" })
vim.keymap.set("n", "<leader>sM", ":Telescope keymaps<CR>", { silent = true, desc = "keymaps" })
vim.keymap.set("n", "<leader>sp", ":Telescope help_tags<CR>", { silent = true, desc = "help tags" })
vim.keymap.set("n", "<leader>sP", ":Telescope tags<CR>", { silent = true, desc = "tags" })
vim.keymap.set("n", "<leader>ss", ":Telescope snippets snippets<CR>", { silent = true, desc = "snippets" })
vim.keymap.set("n", "<leader>sS", ":Telescope colorscheme<CR>", { silent = true, desc = "colorscheme" })
vim.keymap.set("n", "<leader>st", ":Telescope current_buffer_tags<CR>", { silent = true, desc = "buffer tags" })
vim.keymap.set("n", "<leader>sy", ":Telescope filetypes<CR>", { silent = true, desc = "filetypes" })
vim.keymap.set("n", "<leader>sf", ":Telescope find_files<CR>", { silent = true, desc = "files" })
vim.keymap.set("n", "<leader>sw", ":Telescope live_grep<CR>", { silent = true, desc = "live grep" })

set_group_name("<leader>S", "Session")
vim.keymap.set("n", "<leader>SS", ":SessionManager save_current_session<CR>", { silent = true, desc = "save session" })
vim.keymap.set("n", "<leader>SL", ":SessionManager load_current_dir_session<CR>", { silent = true, desc = "last session in dir" })
vim.keymap.set("n", "<leader>Sl", ":SessionManager load_last_session<CR>", { silent = true, desc = "last session" })

set_group_name("<leader>x", "Execute")
vim.keymap.set("n", "<leader>xc", function() return require("general.debug").execute_line() end, { silent = true, desc = "current line" })
vim.keymap.set("n", "<leader>xf", function() return require("general.debug").load_file() end, { silent = true, desc = "file" })
vim.keymap.set("v", "<leader>xx", function() return require("general.debug").execute_visual_selection() end, { silent = true, desc = "selection" })

set_group_name("<leader>g", "Git")
vim.keymap.set("n", "<leader>gA", ":Git add .<CR>", { silent = true, desc = "add all" })
vim.keymap.set("n", "<leader>ga", ":Git add %<CR>", { silent = true, desc = "add file" })
vim.keymap.set("n", "<leader>gb", ":Git blame<CR>", { silent = true, desc = "blame" })
vim.keymap.set("n", "<leader>gB", ":GBrowse<CR>", { silent = true, desc = "browse" })
vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { silent = true, desc = "commit" })
vim.keymap.set("n", "<leader>gd", ":Git diff<CR>", { silent = true, desc = "diff" })
vim.keymap.set("n", "<leader>gD", ":Gdiffsplit<CR>", { silent = true, desc = "diff split" })
vim.keymap.set("n", "<leader>gg", ":GGrep<CR>", { silent = true, desc = "grep" })
vim.keymap.set("n", "<leader>gG", ":Gstatus<CR>", { silent = true, desc = "status" })
vim.keymap.set("n", "<leader>gt", ":GitGutterSignsToggle<CR>", { silent = true, desc = "toggle signs" })
vim.keymap.set("n", "<leader>gh", ":GitGutterLineHighlightsToggle<CR>", { silent = true, desc = "hunk highlight" })
vim.keymap.set("n", "<leader>gH", "<Plug>(GitGutterPreviewHunk)", { silent = true, desc = "preview hunk" })
vim.keymap.set("n", "<leader>gj", "<Plug>(GitGutterNextHunk)", { silent = true, desc = "next hunk" })
vim.keymap.set("n", "<leader>gk", "<Plug>(GitGutterPrevHunk)", { silent = true, desc = "previous hunk" })
vim.keymap.set("n", "<leader>gs", "<Plug>(GitGutterStageHunk)", { silent = true, desc = "stage hunk" })
vim.keymap.set("n", "<leader>gu", "<Plug>(GitGutterUndoHunk)", { silent = true, desc = "undo hunk" })
vim.keymap.set("n", "<leader>gl", ":Git log<CR>", { silent = true, desc = "log" })
vim.keymap.set("n", "<leader>gp", ":Git pull<CR>", { silent = true, desc = "pull" })
vim.keymap.set("n", "<leader>gP", ":Git push<CR>", { silent = true, desc = "push" })
vim.keymap.set("n", "<leader>gr", ":GRemove<CR>", { silent = true, desc = "remove" })

set_group_name("<leader>d", "Debug")
vim.keymap.set("n", "<leader>db", function() return require"dap".toggle_breakpoint() end, { silent = true, desc = "toggle breakpoint" })
vim.keymap.set("n", "<leader>dc", function() return require"dap".continue() end, { silent = true, desc = "continue" })
vim.keymap.set("n", "<leader>dS", function() return require"dap".step_over() end, { silent = true, desc = "step over" })
vim.keymap.set("n", "<leader>ds", function() return require"dap".step_into() end, { silent = true, desc = "step into" })
vim.keymap.set("n", "<leader>dr", function() return require"dap".repl.open() end, { silent = true, desc = "inspect in REPL" })

return M
