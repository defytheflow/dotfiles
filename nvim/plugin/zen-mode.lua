local zen_mode = require("zen-mode")

zen_mode.setup {
  window = {
    width = 1,
  },
  options = {
    cursorline = false,
  },
  on_open = function(win)
    vim.wo.colorcolumn = ""
  end,
  on_close = function()
    vim.wo.colorcolumn = "+0"
  end,
}

vim.keymap.set("n", "<leader>z", zen_mode.toggle, { desc = "[Z]en mode" })
