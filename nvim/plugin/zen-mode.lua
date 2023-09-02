local zen_mode = require("zen-mode")

zen_mode.setup {
  window = {
    width = 1,
  },
}

vim.keymap.set("n", "<leader>z", zen_mode.toggle)
