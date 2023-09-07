-- Enables emoji abbreviations and digraphs.
-- Can't be declared inside vim-plug plugins block, gets overwritten by other plugins or something.

local emoji_ab_group = vim.api.nvim_create_augroup("VimrcEmojiAb", {})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = emoji_ab_group,
  callback = function() vim.cmd.runtime("macros/emoji-ab.vim") end,
})
