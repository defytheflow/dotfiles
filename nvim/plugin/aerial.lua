require("aerial").setup {
  autojump = true,
  layout = {
    min_width = 30,
  },
  close_on_select = true,
}

vim.keymap.set("n", "<leader>o", vim.cmd.AerialToggle, { desc = "[O]utline" })
