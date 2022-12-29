local telescope = require"telescope"

telescope.load_extension"fzy_native"
telescope.load_extension"notify"
telescope.setup{ defaults = { file_ignore_patterns = { "node_modules" } } }
