local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command
local set_var = vim.api.nvim_set_var
local get_var = vim.api.nvim_get_var

-- This is for non-plugin specific user commands and autocmds

-- Highlight on yank
local group = augroup("highlight_yank", { clear = true })
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  group = group,
})

-- Set kitty background to colorscheme background
group = augroup("kitty_background", { clear = true })

local set_kitty_bg = function(bg)
  vim.fn.system("kitty @ set-colors background='"..bg.."'")
end
local kitty_bg = vim.fn.system("kitty @ get-colors | grep '^background' | tr -s ' ' | cut -d' ' -f2")
kitty_bg = kitty_bg:sub(1,7)
autocmd("VimLeavePre", {
  callback = function()
    set_kitty_bg(kitty_bg)
  end,
  group = group,
})
autocmd("ColorScheme", {
  callback = function()
    local bg = vim.api.nvim_get_hl(0,{name="Normal"}).bg
    if bg then
      bg = "#"..string.format("%x", bg)
      set_kitty_bg(bg)
    end
  end,
  group = group,
})
