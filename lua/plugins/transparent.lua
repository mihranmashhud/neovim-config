local transparent = require"transparent"
transparent.setup{
  extra_groups = { 
    "NormalFloat",
    "TelescopeBorder",
    "FloatermBorder",
    "WhichKeyBorder",
    "FloatBorder",
  },
}
transparent.clear_prefix("GitSigns")
transparent.clear_prefix("Diagnostic")
