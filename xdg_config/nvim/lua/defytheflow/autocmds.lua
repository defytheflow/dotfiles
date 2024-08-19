local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufWritePre" }, {
  group = augroup("vimrc_trailing_whitespace", {}),
  pattern = "*",
  callback = function() vim.cmd("%s/\\s\\+$//e"); vim.cmd("%s/\n\\+\\%$//e") end,
  desc = "Remove trailing whitespace",
})

autocmd({ "BufNewFile", "BufRead" }, {
  group = augroup("vimrc_jsonc", {}),
  pattern = { "coc-settings.json", "tsconfig.json", "settings.json", "keybindings.json", "*code-snippets" },
  callback = function() vim.opt_local.filetype = "jsonc" end,
})

autocmd({ "FileType" }, {
  group = augroup("vimrc_vimwiki", {}),
  pattern = "vimwiki",
  callback = function() vim.cmd.runtime("ftplugin/text.lua"); vim.cmd.runtime("ftplugin/markdown.lua") end,
})

-- NOTE: When you decide to put autocmds for saving folds state, make sure that nohlsearch
-- and Telescope find_files still work.

autocmd({ "TextYankPost" }, {
  group = augroup("vimrc_highlight_yank", {}),
  pattern = "*",
  callback = function() vim.highlight.on_yank { higroup = "IncSearch", timeout = 200 } end,
})

local misc_group = augroup("vimrc_misc", {})

autocmd({ "VimEnter" }, {
  group = misc_group,
  pattern = "*",
  callback = function() vim.cmd.NoMatchParen() end,
})

autocmd({ "FileType" }, {
  group = misc_group,
  pattern = "*",
  callback = function() vim.opt.formatoptions:remove { "c", "r", "o" } end,
  desc = "Disable auto commenting",
})
