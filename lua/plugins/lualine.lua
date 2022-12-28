require"lualine".setup{
  options = {
    theme = "auto",
    disabled_filetypes = { statusline = { "alpha", "lazy" } },
    icons_enabled = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    },
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch", "diagnostics"},
    lualine_c = {"filename",},
    lualine_x = {
      {
        function()
          local navic = require("nvim-navic")
          local ret = navic.get_location()
          return ret:len() > 2000 and "navic error" or ret
        end,
        cond = function()
          if package.loaded["nvim-navic"] then
            local navic = require("nvim-navic")
            return navic.is_available()
          end
        end,
      },
      "filetype",
    },
    lualine_y = {"location"},
    lualine_z = {"progress"},
  },
  tabline = {
    lualine_a = {},
    lualine_b = {
      {
        "filetype",
        icon_only = true,
      },
      "filename",
    },
    lualine_c = {
    },
    lualine_x = {},
    lualine_y = {
      {
        "tabs",
        mode = 2,
      }
    },
    lualine_z = {},
  },
  winbar = {},
  inactive_winbar = {
    lualine_a = {},
    lualine_b = {
      {
        "filename",
        path = 1,
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  -- TODO: Switch to neo-tree
  extensions = {"nvim-tree"},
}
