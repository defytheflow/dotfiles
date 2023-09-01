pcall(function()
  vim.cmd.colorscheme("xcodedarkhc")
  require("lualine").setup()
end)

vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt_local.foldenable = false

vim.opt_local.makeprg = "swift %"

vim.keymap.set("n", "<leader>mt", function()
  vim.cmd.write()
  vim.cmd.term(vim.opt_local.makeprg:get())
end,
{ desc = "[M]ake [T]erm" })

vim.keymap.set("n", "<leader>ms", function()
  vim.cmd.write()
  vim.cmd.split()
  vim.cmd.term(vim.opt_local.makeprg:get())
end,
{ desc = "[M]ake [S]plit" })
