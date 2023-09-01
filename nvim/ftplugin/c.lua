vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

vim.opt_local.makeprg = "make %< && ./%<"

vim.keymap.set("n", "<leader>mt", function()
  vim.cmd.write()
  vim.cmd.term(vim.opt_local.makeprg:get())
end,
{ desc = "[M]ake [T]erm" })
