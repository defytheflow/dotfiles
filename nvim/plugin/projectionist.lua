vim.g.projectionist_heuristics = {
  ["package.json&tsconfig.json"] = {
    ["*.tsx"] = {
      type = "source",
      alternate = { "{}.scss", "{}.module.scss", "{}.test.tsx" },
      related = { "{}.test.tsx", "{}.stories.tsx" },
    },
    ["*.test.tsx"] = { type = "test", alternate = "{}.tsx" },
    ["*.scss"] = { type = "style", alternate = "{}.tsx" },
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

vim.keymap.set("n", "<leader>aa", vim.cmd.A, { desc = "[A]lternative [A]lternative" })
vim.keymap.set("n", "<leader>as", vim.cmd.AS, { desc = "[A]lternative [S]plit" })
vim.keymap.set("n", "<leader>av", vim.cmd.AV, { desc = "[A]lternative [V]split" })
