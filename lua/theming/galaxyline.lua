local gl = require('galaxyline')
--local colors = require('galaxyline.theme').default
local colors = require('iris.palette').get()
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
table.insert(gls.left, {
  DiagnosticError = {
    provider = 'DiagnosticError',
    icon = '  ',
    highlight = {colors.red,colors.bg}
  }
})

table.insert(gls.left, {
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    highlight = {colors.yellow,colors.bg},
  }
})

table.insert(gls.left, {
  DiagnosticHint = {
    provider = 'DiagnosticHint',
    icon = '  ',
    highlight = {colors.green,colors.bg},
  }
})

table.insert(gls.left, {
  DiagnosticInfo = {
    provider = 'DiagnosticInfo',
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
