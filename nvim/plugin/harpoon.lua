local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ma", mark.add_file, { desc = "[M]ark [A]dd" })
vim.keymap.set("n", "<leader>mm", ui.toggle_quick_menu, { desc = "[M]ark [M]ark" })

vim.keymap.set("n", "<leader>m1", function() ui.nav_file(1) end, { desc = "[M]ark 1" })
vim.keymap.set("n", "<leader>m2", function() ui.nav_file(2) end, { desc = "[M]ark 2" })
vim.keymap.set("n", "<leader>m3", function() ui.nav_file(3) end, { desc = "[M]ark 3" })
vim.keymap.set("n", "<leader>m4", function() ui.nav_file(4) end, { desc = "[M]ark 4" })

vim.keymap.set("n", "<leader>mf", function() ui.nav_file(1) end, { desc = "[M]ark [F]irst" })
vim.keymap.set("n", "<leader>mt", function() ui.nav_file(3) end, { desc = "[M]ark [T]hird" })
vim.keymap.set("n", "<leader>ms", function() ui.nav_file(2) end, { desc = "[M]ark [S]econd" })
