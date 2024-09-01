-- This plugin is loaded in typescriptreact files as well.

vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt_local.foldenable = false

  -- TODO:
  -- fallback to tsc and node

local executables = { "bun", "deno", "ts-node" }

for _, executable in ipairs(executables) do
  if vim.fn.executable(executable) == 1 then
    vim.opt_local.makeprg = executable .. " %"
    break
  end
end
