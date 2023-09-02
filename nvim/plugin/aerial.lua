require("aerial").setup {
  autojump = true,
  layout = {
    min_width = 30,
    -- default_direction = "prefer_left"
  },
  close_on_select = true,
}

vim.keymap.set("n", "<leader>o", vim.cmd.AerialToggle)
