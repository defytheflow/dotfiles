-- vimrc
local myvimrc = vim.fn.expand("$MYVIMRC")
vim.api.nvim_create_user_command("Rld", function() vim.cmd.source(myvimrc) end, {})
vim.keymap.set("n", "<leader>ve", function() vim.cmd.edit(myvimrc) end, { desc = "[V]im [E]dit" })
vim.keymap.set("n", "<leader>vs", function() vim.cmd.split(myvimrc) end, { desc = "[V]im [S]plit" })
vim.keymap.set("n", "<leader>vv", function() vim.cmd.vsplit(myvimrc) end, { desc = "[V]im [V]split" })

-- center the screeen after a cursor jump
for _, keymap in ipairs { "n", "N", "<C-d>", "<C-u>", "<C-o>", "<C-i>" } do
  vim.keymap.set("n", keymap, keymap .. "zz")
end

-- misc
vim.keymap.set("n", "<leader>d", vim.cmd.bdelete)
vim.keymap.set("n", "<leader>D", function() vim.cmd.bprevious() vim.cmd.bdelete('#') end)
vim.keymap.set("n", "<leader>mk", function() vim.cmd.write() vim.cmd.make() end, { desc = "[M]a[k]e" })

-- press << or >> multiple times, maintaining visual selection
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- move visual selection up or down
-- TODO: come up with a keymap
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
