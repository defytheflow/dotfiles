pcall(function()
  -- Display file icons in the sign column.
  require("netrw").setup()
end)

-- Keep the current directory and the browsing directory synced.
-- This helps avoid the move files error.
vim.g.netrw_keepdir = 0

-- Change the size to 30% when netrw creates a split.
vim.g.netrw_winsize = 30

-- Highlight marked files in the same way search matches are.
vim.cmd.highlight { "link", "netrwMarkFile", "Search" }
