require("dashboard").setup {
  theme = "hyper",
  config = {
    week_header = {
     enable = true,
    },
    shortcut = {
      { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
      {
        icon = " ",
        icon_hl = "@variable",
        desc = "Files",
        group = "Label",
        action = "Telescope find_files",
        key = "f",
      },
      {
        desc = " dotfiles",
        group = "Number",
        action = function()
          require("telescope.builtin").find_files {
            cwd = vim.env.DOTFILES_HOME or vim.fn.stdpath("config"),
          }
        end,
        key = "d",
      },
    },
    footer = {
      "",
      "🚀 Interested people watch obsessed people change the world.",
      "",
    }
  },
}
