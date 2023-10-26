require"conform".setup {
  formatters_by_ft = {
    lua = {"stylua"},
    python = {"isort", "black"},
    javascript = {"prettierd", "prettier"},
  },
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if not vim.g.formatonsave or not vim.b[bufnr].formatonsave then
      return
    end
    return { timeout_ms = 500, lsp_fallback = true }
  end,
}

-- Disable autoformat initially
vim.g.formatonsave = false

-- User commands
vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      ["start"] = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.g.formatonsave = false
  else
    -- Default to current buffer
    vim.b.formatonsave = false
  end
end, { desc = "Disable autoformat-on-save", bang = true})

vim.api.nvim_create_user_command("FormatEnable", function(args)
  if args.bang then
    vim.g.formatonsave = true
  else
    -- Default to current buffer
    vim.b.formatonsave = true
  end
end, { desc = "Enable autoformat-on-save", bang = true})

vim.api.nvim_create_user_command("FormatToggle", function(args)
  if args.bang then
    vim.g.formatonsave = not vim.g.formatonsave
  else
    -- Default to current buffer
    vim.b.formatonsave = not vim.b.formatonsave
  end
end, { desc = "Toggle autoformat-on-save", bang = true})
