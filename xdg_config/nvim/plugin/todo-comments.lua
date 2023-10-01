local todo_comments = require("todo-comments")

todo_comments.setup {
  highlight = {
    after = "", -- don't highlight text after the keyword
    -- keyword = "fg",
  },
}

vim.keymap.set("n", "]t", function() todo_comments.jump_next() end, { desc = "Next [T]odo comment" })
vim.keymap.set("n", "[t", function() todo_comments.jump_prev() end, { desc = "Previous [T]odo comment" })
