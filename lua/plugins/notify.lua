require"notify".setup{
  stages = "fade_in_slide_out",
  on_open = nil,
  on_close = nil,
  render = "default",
  timeout = 4000,
  minimum_width = 30,
  background_colour = "#000000",
  icons = {
    ERROR = " ",
    WARN = " ",
    INFO = " ",
    DEBUG = " ",
    TRACE = " ",
  },
}
vim.notify = require"notify"

local nvim_dir
if vim.fn.has"win32" > 0 then
  nvim_dir = "AppData/Local/nvim"
else
  nvim_dir = ".config/nvim"
end

if vim.fn.getcwd():find(nvim_dir) ~= nil then
  local status = vim.fn.system{ "git", "status" }
  local opts = { title = "Neovim Config" }
  if status:find "Your branch is behind" then
    vim.notify("New commits on remote! Please pull to update Neovim config.",
               "warn", opts)
  elseif status:find "Your branch is ahead" then
    vim.notify(
      "New commits on local! Please push Neovim config updates to remote.",
      "warn", opts)
  elseif status:find "Changes not staged" then
    vim.notify("Changes have not been commited! Please commit.", "warn", opts)
  elseif status:find "Untracked files" then
    vim.notify(
      "Some files are untracked! Please either git ignore them or add them to a commit.",
      "warn", opts)
  end
end
