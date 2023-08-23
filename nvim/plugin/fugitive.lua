vim.opt.previewheight = 22

vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>")
vim.keymap.set("n", "<leader>gd", "<cmd>Gdiff<cr>")
vim.keymap.set("n", "<leader>gl", "<cmd>GV<cr>") -- from 'junegunn/gv.vim' plugin, depends on vim-fugitive
vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>")
