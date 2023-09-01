vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

-- TODO: doesn't run if you open a json file on startup (nvim example.json)
vim.cmd.DoMatchParen()
