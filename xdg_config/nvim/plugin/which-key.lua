require("which-key").setup()

require("which-key").register {
  { "<leader>g", group = "[G]it" },
  -- { "<leader>g_", hidden = true },
  { "<leader>h", group = "[H]unk (more git)" },
  -- { "<leader>h_", hidden = true },
  { "<leader>s", group = "[S]earch" },
  -- { "<leader>s_", hidden = true },
  { "<leader>t", group = "[T]est" },
  -- { "<leader>t_", hidden = true },
  { "<leader>v", group = "[V]im" },
  -- { "<leader>v_", hidden = true },
}

vim.keymap.set("n", "<leader>", function() vim.cmd.WhichKey("<leader>") end)
