vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.softtabstop = 2

vim.opt_local.wrap = true
vim.opt_local.linebreak = true -- break line at words.

vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.thesaurus:append("~/.config/nvim/thesaurus/mthesaur.txt")
vim.opt_local.complete:append("s") -- search thesaurus for autocomplete.

local function HighlightBadSpelling()
  vim.cmd.highlight({ "SpellBad", "guifg=#ef4444", "ctermfg=Red" })
end

local text_group = vim.api.nvim_create_augroup("vimrc_text", { clear = true })

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  pattern = { "*" },
  group = text_group,
  callback = HighlightBadSpelling,
})

HighlightBadSpelling()
