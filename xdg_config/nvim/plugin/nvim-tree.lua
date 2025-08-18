local api = require("nvim-tree.api")

require("nvim-tree").setup {
  hijack_netrw = true,
  view = {
    width          = { min = 33 },
    number         = true,
    relativenumber = true,
  },
  renderer = {
    indent_markers = {
      enable = true,
    },
    icons = {
      git_placement = "after",
    },
  },
  diagnostics = {
    enable = true,
  },
  update_focused_file = {
    enable = true,
  },
  filters = {
    git_ignored = false,
    custom = {
      "*.pyc",
      ".DS_Store",
      ".mypy_cache",
      ".ruff_cache",
      ".pytest_cache",
      "__pycache__",
    }, -- names that will not be shown
  },
}

vim.keymap.set("n", "<leader>n", api.tree.toggle, { desc = "[N]vim Tree" })
