vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8

vim.g.floaterm_autoinsert = true
vim.g.floaterm_winblend = 0

vim.api.nvim_create_user_command("Node", function() vim.cmd.FloatermNew("node") end, {})
vim.api.nvim_create_user_command("Python3", function() vim.cmd.FloatermNew("python3") end, {})
vim.api.nvim_create_user_command("Ranger", function() vim.cmd.FloatermNew("ranger") end, {})

vim.keymap.set("n", "<leader>R", vim.cmd.Ranger)

-- nnoremap <silent> <leader>r :Ranger<CR>
-- nnoremap <silent> <C-t>     :FloatermToggle<CR>
-- nnoremap <silent> <C-q>     :FloatermKill<CR>

-- let g:floaterm_keymap_prev   = '<leader>fp'
-- let g:floaterm_keymap_next   = '<leader>fn'

-- tnoremap <silent> <C-t> <C-\><C-n>:FloatermToggle<CR>
-- tnoremap <silent> <C-q> <C-\><C-n>:FloatermKill<CR>
