require("which-key").setup()

require("which-key").register {
  ["<leader>g"] = { name = "[G]it", _ = "which_key_ignore" },
  ["<leader>h"] = { name = "[H]unk (more git)", _ = "which_key_ignore" },
  ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
  ["<leader>t"] = { name = "[T]est", _ = "which_key_ignore" },
  ["<leader>v"] = { name = "[V]im", _ = "which_key_ignore" },
}

vim.keymap.set("n", "<leader>", function() vim.cmd.WhichKey("<leader>") end)
