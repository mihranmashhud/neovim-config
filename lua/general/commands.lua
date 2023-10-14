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
