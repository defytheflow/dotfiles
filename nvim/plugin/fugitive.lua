vim.opt.previewheight = 22

vim.keymap.set("n", "<leader>gc", function() vim.cmd.Git("commit") end, { desc = "[G]it [C]ommit" })
vim.keymap.set("n", "<leader>gd", vim.cmd.Gdiff, { desc = "[G]it [D]iff" })
vim.keymap.set("n", "<leader>gl", function() vim.cmd.Git("log") end, { desc = "[G]it [l]og" })
vim.keymap.set("n", "<leader>gL", vim.cmd.GV, { desc = "[G]it [L]og (oneline)" }) -- from gv.vim, depends on vim-fugitive
vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })
