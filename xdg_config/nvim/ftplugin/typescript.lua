-- This plugin is loaded in typescriptreact files as well.

vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt_local.foldenable = false

-- TODO:
-- check if bun installed
-- check if ts-node installed
-- fallback to tsc and node
vim.opt_local.makeprg = "bun %"
