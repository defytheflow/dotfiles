-- Status line.
require("lualine").setup()

-- Terminal toggle.
require("toggleterm").setup {
  open_mapping = [[<c-\>]],
  -- shade_terminals = false,
}

-- Highlight trailing whitespace
require("mini.trailspace").setup()

-- Disable highlighting on dashboard page
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dashboard",
  callback = function(data)
    vim.b[data.buf].minitrailspace_disable = true
    vim.api.nvim_buf_call(data.buf, MiniTrailspace.unhighlight)
  end,
})

-- SETTINGS

-- path
vim.opt.path:append(os.getenv("HOME") .. "/.config/nvim/*plugin/") -- search files with `:find` command

-- backup
vim.opt.backup = true
vim.opt.backupdir = os.getenv("HOME") .. "/.local/state/nvim/backup"

-- colorscheme
vim.opt.termguicolors = true -- use guifg/guibg instead of ctermfg/ctermbg in terminal

if not pcall(function()
  local colorschemes = {
    "tokyonight-moon",
    "tokyonight-day",
    "night-owl",
    "base16-classic-dark",
    "base16-gruvbox-dark-hard",
    "gruvbox",
    "base16-ocean",
  }
  vim.cmd.colorscheme(colorschemes[1])
end) then
  vim.cmd.colorscheme("koehler")
end

-- command line
vim.opt.wildmode = { "longest", "list", "full" }
vim.opt.wildignore:append { "*/.git/*", "*/.venv/*", "*/node_modules/*", "*cache*", "*coverage*" }
vim.opt.wildignorecase = true

-- gui
vim.opt.guifont = "FiraCode:h11"

-- cursor
vim.opt.guicursor = "i:block" -- use block cursor in insert mode

-- gutter
vim.opt.number = true
vim.opt.relativenumber = true

-- indent
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true -- convert <tab> key presses to spaces
vim.opt.smartindent = true

-- search
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- splits
vim.opt.fillchars:append("vert:┃")
vim.opt.splitbelow = true
vim.opt.splitright = true

-- text width
vim.opt.wrap = false
vim.opt.textwidth = 90
vim.opt.colorcolumn = "+0" -- display a colorcolumn using the value of textwidth option
vim.opt.sidescrolloff = 10

-- scroll off
-- vim.opt.scrolloff = 10 - doesn't allow to do zt to the top of the buffer

-- undo
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.local/state/nvim/undo"

-- whitespace
vim.opt.list = true -- render whitespace with characters
vim.opt.listchars = {
  tab = "ᐅ-",
  -- trail = "•",
  nbsp = "⦸",
  extends = "»",
  precedes = "«",
  -- lead = "·",
  -- eol = "↴",
}

-- cursorline
vim.opt.cursorline = true

-- miscellaneous
vim.opt.exrc = true -- auto execute .nvim.lua, .nvimrc in the current dir
vim.opt.mouse = "a" -- enable mouse in all modes
vim.opt.virtualedit = "block" -- allow cursor to move where there is no text in visual block mode.
vim.opt.timeoutlen = 500
-- vim.opt.lazyredraw = false

-- KEYMAPS

-- vimrc
local myvimrc = vim.fn.expand("$MYVIMRC")
vim.api.nvim_create_user_command("Rld", function() vim.cmd.source(myvimrc) end, {})
vim.keymap.set("n", "<leader>ve", function() vim.cmd.edit(myvimrc) end, { desc = "[V]im [E]dit" })
vim.keymap.set("n", "<leader>vs", function() vim.cmd.split(myvimrc) end, { desc = "[V]im [S]plit" })
vim.keymap.set("n", "<leader>vv", function() vim.cmd.vsplit(myvimrc) end, { desc = "[V]im [V]split" })

-- center the screeen after a cursor jump
for _, keymap in ipairs { "n", "N", "<C-d>", "<C-u>", "<C-o>", "<C-i>" }  do
  vim.keymap.set("n", keymap, keymap .. "zz")
end

-- misc
vim.keymap.set("n", "<leader>d", vim.cmd.bdelete)
vim.keymap.set("n", "<leader>mk", function() vim.cmd.write(); vim.cmd.make() end)

-- press << or >> multiple times, maintaining visual selection
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- move visual selection up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
