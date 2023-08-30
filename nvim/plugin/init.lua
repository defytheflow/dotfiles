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
