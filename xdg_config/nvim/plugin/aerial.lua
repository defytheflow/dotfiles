local aerial = require("aerial")

local function fold_all_symbols()
  -- In `jsx` and `tsx` files aerial expands every jsx expression.
  -- This hides all jsx and leaves only top level symbols.
  aerial.tree_close_all()
end

aerial.setup {
  autojump = true,
  layout = {
    min_width = 30,
  },
  filter_kind = {
    -- Defaults
    "Class",
    "Constructor",
    "Enum",
    "Function",
    "Interface",
    "Module",
    "Method",
    "Struct",
    -- Custom
    "Variable",
  },
  close_on_select = true,
  on_attach = function()
    fold_all_symbols()
  end
}

vim.keymap.set("n", "<leader>o", function()
  aerial.toggle()
  fold_all_symbols()
end, { desc = "[O]utline" })
