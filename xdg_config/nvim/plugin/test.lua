vim.g["test#strategy"] = "floaterm" -- neovim
vim.g["test#neovim#term_position"] =  "below 40" -- [vert, below]
vim.g["test#javascript#runner"] = "jest"
vim.g["test#javascript#jest#executable"] = "npm test"

vim.keymap.set("n", "<leader>tf", vim.cmd.TestFile, { desc = "[T]est [F]ile" })
vim.keymap.set("n", "<leader>tl", vim.cmd.TestLast, { desc = "[T]est [L]ast" })
vim.keymap.set("n", "<leader>tn", vim.cmd.TestNearest, { desc = "[T]est [N]earest" })
vim.keymap.set("n", "<leader>ts", vim.cmd.TestSuite, { desc = "[T]est [S]uite" })
vim.keymap.set("n", "<leader>tv", vim.cmd.TestVisit, { desc = "[T]est [V]isit" })
