require"lualine".setup{
  options = {
    theme = "auto",
    disabled_filetypes = { statusline = { "alpha", "lazy" } },
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
    refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diagnostics" },
    lualine_c = {},
    lualine_x = {
      {
        "filename",
        path = 1,
      },
      "filetype",
    },
    lualine_y = { "location" },
    lualine_z = { "progress" },
  },
  tabline = {
    lualine_a = {},
    lualine_b = { { "tabs", mode = 2 } },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { { "filetype", icon_only = true }, "filename" },
    lualine_z = {},
  },
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      "filename",
      {
        "navic", color_correction = "dynamic",
      },
    },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  inactive_winbar = {
    lualine_a = {},
    lualine_b = { { "filename", path = 1 } },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  -- TODO: Switch to neo-tree
  extensions = { "nvim-tree" },
}
