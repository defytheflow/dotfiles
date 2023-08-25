-- Status line.
require("lualine").setup()

-- Terminal toggle.
require("toggleterm").setup({
  open_mapping = [[<c-\>]],
  -- shade_terminals = false,
})

-- Netrw file icons.
require("netrw").setup()

-- Displays available keybindings.
require("which-key").setup()
vim.keymap.set("n", "<leader>", function() vim.cmd.WhichKey("<leader>") end)

-- Dashboard.
require("dashboard").setup({
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
          desc = " Apps",
          group = "DiagnosticHint",
          action = "Telescope app",
          key = "a",
        },
        {
          desc = " dotfiles",
          group = "Number",
          action = "Telescope dotfiles",
          key = "d",
        },
      },
    },
})

-- Highlight trailing whitespace
require("mini.trailspace").setup()

-- Disable highlighting on dashboard page
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  callback = function(data)
    vim.b[data.buf].minitrailspace_disable = true
    vim.api.nvim_buf_call(data.buf, MiniTrailspace.unhighlight)
  end,
})
