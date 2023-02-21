local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command
local set_var = vim.api.nvim_set_var
local get_var = vim.api.nvim_get_var

-- Highlight on yank
local group = augroup("highlight_yank", { clear = true })
autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
  group = group,
})

set_var("formatonsave", false)

-- Format on Save
autocmd("BufWritePre", {
  pattern = "",
  callback = function(ev)
    local formatonsave = get_var("formatonsave")
    if formatonsave then vim.lsp.buf.format({ bufnr = ev.buf }) end
  end,
})

command("FormatOnSave", function()
  local formatonsave = get_var("formatonsave")
  set_var("formatonsave", not formatonsave)
  print("let formatonsave = v:" .. tostring(not formatonsave))
end, {})
