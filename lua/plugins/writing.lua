local autocmd = vim.api.nvim_create_autocmd

autocmd("BufNewfile,BufRead",
        { pattern = "*.Rmd", command = "set filetype=markdown" })
autocmd("BufNewfile,BufRead", { pattern = "*.md", command = "set spell" })

-- Init writing plugins
vim.fn["pencil#init"]()
vim.fn["litecorrect#init"]()
vim.fn["lexical#init"]()

-- Defaults
vim.g["pencil#conceallevel"] = 1
vim.g["pencil#textwidth"] = 80
vim.g["lexical#spelllang"] = { "en_us", "en_ca" }

vim.keymap.set("n", "<leader>ap", ":PencilToggle<CR>",
               { silent = true, desc = "toggle pencil" })
