require("todo-comments").setup {
  highlight = {
    after = "", -- don't highlight text after the keyword
    keyword = "fg",
  },
  keywords = {
    NOTE = { signs = false },
  },
}

vim.keymap.set("n", "]t", function()
  require("todo-comments").jump_next()
end, { desc = "Go to next [T]odo comment" })

vim.keymap.set("n", "[t", function()
  require("todo-comments").jump_prev()
end, { desc = "Go to previous [T]odo comment" })

vim.keymap.set("n", "<leader>ft", vim.cmd.TodoTelescope, { desc = "[F]ind [T]odos" })
vim.keymap.set("n", "<leader>st", vim.cmd.TodoTelescope, { desc = "[S]earch [T]odos" })
