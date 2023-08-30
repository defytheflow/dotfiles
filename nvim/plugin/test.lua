vim.g["test#strategy"] = "floaterm" -- neovim
vim.g["test#neovim#term_position"] =  "below 40" -- [vert, below]
vim.g["test#javascript#runner"] = "jest"
vim.g["test#javascript#jest#executable"] = "npm test"

vim.keymap.set("n", "<leader>tf", vim.cmd.TestFile)
vim.keymap.set("n", "<leader>tl", vim.cmd.TestLast)
vim.keymap.set("n", "<leader>tn", vim.cmd.TestNearest)
vim.keymap.set("n", "<leader>ts", vim.cmd.TestSuite)
vim.keymap.set("n", "<leader>tv", vim.cmd.TestVisit)
