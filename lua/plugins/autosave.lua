local exclude_filetypes = {
      "markdown",
      "rmarkdown",
      "pandoc",
      "latex",
}

local exclude_files = {}

require"auto-save".setup{
  enabled = true,
  condition = function (buf)
    local fn = vim.fn
    local utils = require"auto-save.utils.data"
    return fn.getbufvar(buf, "&modifiable") == 1
      and utils.not_in(fn.getbufvar(buf, "&filetype"), exclude_filetypes)
      and utils.not_in(fn.expand("%:t"), exclude_files)
  end
}
