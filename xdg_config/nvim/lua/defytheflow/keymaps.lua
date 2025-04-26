--- Check if a keymap exists in a given mode.
local function keymap_exists(mode, lhs)
  for _, map in ipairs(vim.api.nvim_get_keymap(mode)) do
    if map.lhs == lhs then
      return true
    end
  end
  return false
end

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
-- vim.keymap.set("n", "<leader>d", vim.cmd.bdelete)
-- vim.keymap.set("n", "<leader>D", function() vim.cmd.bprevious() vim.cmd.bdelete('#') end)

-- NOTE: We define a <leader>mk keybind inside toggleterm.lua which loads first.
-- In case in the future i remove this plugin, this will act as a fallback
if not keymap_exists("n", vim.g.mapleader .. "mk") then
  vim.keymap.set("n", "<leader>mk", "<Cmd>w<CR><Cmd>make!<CR>", { desc = "[M]a[k]e" })
end

-- common typo
vim.api.nvim_create_user_command("Bd", function() vim.cmd.bd() end, {})

-- press `<<` or `>>` multiple times, maintaining visual selection
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- move between tabs with `T]` and `[T`
vim.keymap.set("n", "]T", vim.cmd.tabnext, { desc = "Go to next [T]ab" });
vim.keymap.set("n", "[T", vim.cmd.tabprevious, { desc = "Go to previous [T]ab" });

-- move visual selection up or down
-- TODO: come up with a keymap
-- vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
-- vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- vim.keymap.set("n", "<leader>p", function()
--   vim.cmd("!npx prettier --write %")
-- end, {})

-- vim.keymap.set("n", "<leader>p", [[:!npx prettier --write %<CR>]], {})
