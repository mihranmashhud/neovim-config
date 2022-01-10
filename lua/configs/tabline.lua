local inactive = {
  black = '#000000',
  white = '#ffffff',
  fg = '#696969',
  bg_1 = '#181A1F',
  bg_2 = '#202728',
  index = '#61afef',
}
local active = vim.tbl_extend('force', inactive, {
  fg = '#abb2bf',
  bg_2 = '#282c34',
  index = '#d19a66',
})

local render = function (f)
  f.add' '
  f.make_tabs(function (info)
    local colors = info.current and active or inactive
    f.add {
      ' '..info.index..' ',
      fg = colors.index,
      bg = colors.bg_1,
    }
    f.set_colors{ fg = colors.fg, bg = colors.bg_2 }
    if type(info.filename) == 'string' then
      local ok, val = pcall(f.icon_color, info.filename)
      if ok then
        f.add' '
        f.add{
          f.icon(info.filename),
          fg = info.current and val or nil
        }
        f.add' '
      end
      f.add(info.filename)
      f.add(info.modified and ' ')
    else
      f.add(info.modified and '[+]' or '[-]')
    end
    f.add' '
  end)
end

require'tabline_framework'.setup{
  render = render,
  hl = { fg = '#abb2bf', bg = '#181A1F' },
  hl_sel = { fg = '#abb2bf', bg = '#282c34'},
  hl_fill = { fg = '#ffffff', bg = '#000000'},
}
