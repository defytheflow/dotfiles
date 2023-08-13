local api = require("nvim-tree.api")

require("nvim-tree").setup({
  view = {
    width = 35,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = "after",
    },
  },
  update_focused_file = {
    enable = true,
  },
  filters = {
    git_ignored = false,
  },
})

vim.keymap.set("n", "<leader>n", api.tree.toggle, { desc = "Toggle nvim-tree" })
