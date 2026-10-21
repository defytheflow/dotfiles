vim.g.projectionist_heuristics = {
  ["package.json|tsconfig.json"] = {
    ["*.tsx"] = {
      type = "source",
      alternate = { "{}.css", "{}.scss", "{}.module.css", "{}.module.scss", "{}.test.tsx" },
      related = { "{}.test.tsx", "{}.stories.tsx" },
    },
    ["*.test.tsx"] = { type = "test", alternate = "{}.tsx" },
    ["*.css"] = { type = "style", alternate = "{}.tsx" },
    ["*.scss"] = { type = "style", alternate = "{}.tsx" },
    ["*.module.css"] = { type = "style", alternate = "{}.tsx" },
    ["*.module.scss"] = { type = "style", alternate = "{}.tsx" },
    ["*.stories.tsx"] = { type = "story", alternate = "{}.tsx" },
  },
  Pipfile = {
    ["*.py"] = {
      type = "source",
      alternate = "{dirname}/tests/test_{basename}.py",
    },
    ["src/apps/**/tests/test_*.py"] = {
      type = "test",
      alternate = "src/apps/{dirname}/{basename}.py",
    },
  },
}

local function open_alternate(command)
  -- Refresh rules for the current buffer if startup detection happened before they were available.
  vim.cmd("doautocmd <nomodeline> projectionist FileType")
  vim.cmd[command]()
end

vim.keymap.set("n", "<leader>aa", function() open_alternate("A") end, { desc = "[A]lternative [A]lternative" })
vim.keymap.set("n", "<leader>as", function() open_alternate("AS") end, { desc = "[A]lternative [S]plit" })
vim.keymap.set("n", "<leader>av", function() open_alternate("AV") end, { desc = "[A]lternative [V]split" })
