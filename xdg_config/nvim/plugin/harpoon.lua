local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ma", mark.add_file, { desc = "[M]ark [A]dd" })
vim.keymap.set("n", "<leader>mm", ui.toggle_quick_menu, { desc = "[M]ark [M]ark" })

for i = 1,5 do
  vim.keymap.set("n", "<leader>m" .. i, function() ui.nav_file(i) end, { desc = "[M]ark " .. i })
end
