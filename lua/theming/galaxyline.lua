local gl = require('galaxyline')
--local colors = require('galaxyline.theme').default
require'configs.iris' -- colors must be set.
local colors = require('iris.palette').get()
if colors == nil then
  colors = {
    add = "#61794F",
    base00 = "#1a1b26",
    base01 = "#232433",
    base02 = "#232433",
    base03 = "#32344a",
    base04 = "#32344a",
    base05 = "#a9b1d6",
    base06 = "#a9b1d6",
    base07 = "#a9b1d6",
    base08 = "#f7768e",
    base09 = "#ff9e64",
    base0A = "#e0af68",
    base0B = "#9ece6a",
    base0C = "#ad8ee6",
    base0D = "#9ece6a",
    base0E = "#f7768e",
    base0F = "#a9b1d6",
    bg = "#1a1b26",
    black = "#1a1b26",
    blue = "#9ece6a",
    brown = "#a9b1d6",
    change = "#A78558",
    comments = "#32344a",
    cursorline = "#21232F",
    cyan = "#ad8ee6",
    delete = "#8D4D61",
    error = "#f7768e",
    fg = "#a9b1d6",
    green = "#9ece6a",
    grey = "#232433",
    gutter = "#232433",
    hint = "#ad8ee6",
    info = "#9ece6a",
    line_base = "#232433",
    line_dark = "#161720",
    line_lite = "#2D2F3F",
    magenta = "#f7768e",
    none = "NONE",
    orange = "#ff9e64",
    red = "#f7768e",
    warn = "#e0af68",
    white = "#a9b1d6",
    yellow = "#e0af68"
  }
end
local condition = require('galaxyline.condition')
--local vcs = require('galaxyline.provider_vcs')
--local fileinfo = require('galaxyline.provider_fileinfo')
--local extension = require('galaxyline.provider_extensions')
local buffer = require('galaxyline.provider_buffer')
--local whitespace = require('galaxyline.provider_whitespace')
--local lspclient = require('galaxyline.provider_lsp')
--local fileinfo = require('galaxyline.provider_fileinfo')
local autocmd = require('utils.autocmd').autocmd
local gls = gl.section

vim.fn.statusline_bg = function ()
  vim.cmd('hi StatusLine guibg='..colors.bg)
end
autocmd('ColorScheme * :lua vim.fn.statusline_bg()') -- Force the StatusLine bg
vim.fn.statusline_bg()

local mode_text = {
  n      = 'NORMAL',
  i      = 'INSERT',
  v      = 'VISUAL',
  [''] = 'V-BLOCK',
  V      = 'V-LINE',
  c      = 'COMMAND',
  no     = 'OP-PENDING',
  s      = 'SELECT',
  S      = 'SELECT',
  [''] = 'SELECT',
  ic     = 'INS-COMP',
  R      = 'REPLACE',
  Rv     = 'VIRTUAL',
  cv     = 'EX',
  ce     = 'N-EX',
  r      = 'HIT-ENTER',
  rm     = '--MORE',
  ['r?'] = ':CONFIRM',
  ['!']  = 'SHELL',
  t      = 'TERMINAL',
}
local mode_color = {
  n      = colors.blue,
  i      = colors.green,
  v      = colors.magenta,
  [''] = colors.magenta,
  V      = colors.magenta,
  c      = colors.yellow,
  no     = colors.blue,
  s      = colors.red,
  S      = colors.red,
  [''] = colors.red,
  ic     = colors.green,
  R      = colors.brown,
  Rv     = colors.brown,
  cv     = colors.yellow,
  ce     = colors.yellow,
  r      = colors.cyan,
  rm     = colors.cyan,
  ['r?'] = colors.cyan,
  ['!']  = colors.orange,
  t      = colors.orange,
}

gl.short_line_list = {'NvimTree','vista','dbui','packer'}

-- LEFT

table.insert(gls.left, {
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode = vim.fn.mode() -- use this as it provides sane values
      local c = mode_color[mode]
      vim.api.nvim_command('hi GalaxyViMode guibg='..c)
      return '  '..mode_text[mode]..' '
    end,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.bg,colors.bg,'bold'},
  },
})

table.insert(gls.left, {
  GitIcon = {
    provider = function() return '  ' end,
    condition = condition.check_git_workspace,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.violet,colors.bg,'bold'},
  }
})

table.insert(gls.left, {
  GitBranch = {
    provider = 'GitBranch',
    condition = condition.check_git_workspace,
    highlight = {colors.violet,colors.bg,'bold'},
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
  }
})

table.insert(gls.left, {
  DiffAdd = {
    provider = 'DiffAdd',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.green,colors.bg},
  }
})

table.insert(gls.left, {
  DiffModified = {
    provider = 'DiffModified',
    condition = condition.hide_in_width,
    icon = ' 柳',
    highlight = {colors.orange,colors.bg},
  }
})

table.insert(gls.left, {
  DiffRemove = {
    provider = 'DiffRemove',
    condition = condition.hide_in_width,
    icon = '  ',
    highlight = {colors.red,colors.bg},
  }
})

local function lsp_diagnostic_count(severity)
  local count = vim.tbl_count(vim.diagnostic.get(0,{severity = vim.diagnostic.severity[severity]}))
  if count ~= 0 then return count .. ' ' else return '' end
end

table.insert(gls.left, {
  DiagnosticError = {
    provider = function()
      return lsp_diagnostic_count("ERROR")
    end,
    icon = '  ',
    highlight = {colors.red,colors.bg}
  }
})

table.insert(gls.left, {
  DiagnosticWarn = {
    provider = function()
      return lsp_diagnostic_count("WARN")
    end,
    icon = '  ',
    highlight = {colors.yellow,colors.bg},
  }
})

table.insert(gls.left, {
  DiagnosticHint = {
    provider = function()
      return lsp_diagnostic_count("HINT")
    end,
    icon = '  ',
    highlight = {colors.green,colors.bg},
  }
})

table.insert(gls.left, {
  DiagnosticInfo = {
    provider = function()
      return lsp_diagnostic_count("INFO")
    end,
    icon = '  ',
    highlight = {colors.blue,colors.bg},
  }
})

-- MIDDLE

table.insert(gls.mid,{
  FileIcon = {
    provider = 'FileIcon',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg},
  },
})

table.insert(gls.mid, {
  FileName = {
    provider = 'FileName',
    condition = condition.buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.bg,'bold'}
  }
})

-- RIGHT


--table.insert(gls.right, {
--  BufferType = {
--    provider = function ()
--      return buffer.get_buffer_filetype():lower()
--    end,
--    highlight = {colors.blue,colors.bg,'bold'}
--  }
--})

table.insert(gls.right, {
  FileSize = {
    provider = 'FileSize',
    condition = condition.buffer_not_empty and condition.hide_in_width,
    --separator = ' | ',
    --separator_highlight = {colors.fg,colors.bg},
    highlight = {colors.fg,colors.bg}
  }
})

table.insert(gls.right, {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' ',
    separator_highlight = {colors.fg,colors.fg},
    highlight = {colors.bg,colors.fg},
  },
})

table.insert(gls.right, {
  PerCent = {
    provider = 'LinePercent',
    separator = ' |',
    separator_highlight = {colors.bg,colors.fg},
    highlight = {colors.bg,colors.fg,'bold'},
  }
})

table.insert(gls.right, {
  PerCentBar = {
    provider = function ()
      local current_line = vim.fn.line('.') - 1
      local total_lines = vim.fn.line('$') - 1
      local bar_chars = {
        '█',
        '▇',
        '▆',
        '▅',
        '▄',
        '▃',
        '▂',
        '▁',
        ' ',
      }
      local frac
      if total_lines == 0 then
        frac = 0.5
      else
        frac = current_line/total_lines
      end
      local result = math.floor((frac)*(#bar_chars)+1)
      return bar_chars[result] or ' '
    end,
    highlight = {colors.bg, colors.orange}
  }
})

-- SHORT LINE LEFT

table.insert(gls.short_line_left, {
  BufferType = {
		provider = function ()
			return buffer.get_buffer_filetype():lower()
		end,
    separator = ' ',
    separator_highlight = {'NONE',colors.bg},
    highlight = {colors.blue,colors.bg,'bold'}
  }
})

table.insert(gls.short_line_right, {
  BufferIcon = {
    provider= 'BufferIcon',
    highlight = {colors.fg,colors.bg},
  }
})

table.insert(gls.short_line_right, {
  SFileName = {
    provider =  'SFileName',
    condition = condition.buffer_not_empty,
    highlight = {colors.fg,colors.bg,'bold'}
  }
})
