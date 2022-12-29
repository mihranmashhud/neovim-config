local npairs = require"nvim-autopairs"

npairs.setup{ map_cr = true, map_complete = true, auto_select = false }

npairs.add_rules(require("nvim-autopairs.rules.endwise-elixir"))
npairs.add_rules(require("nvim-autopairs.rules.endwise-lua"))
npairs.add_rules(require("nvim-autopairs.rules.endwise-ruby"))
