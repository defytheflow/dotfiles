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

vim.keymap.set("n", "<leader>st", function()
  vim.cmd.TodoTelescope("keywords=TODO,FIXME")
end, { desc = "[S]earch [T]odos" })
