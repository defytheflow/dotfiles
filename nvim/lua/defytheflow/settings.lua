-- path
vim.opt.path:append(os.getenv("HOME") .. "/.config/nvim/*plugin/") -- search files with `:find` command
vim.opt.path:append(os.getenv("HOME") .. "/.config/nvim/lua/defytheflow/") -- search files with `:find` command

-- backup
vim.opt.backup = true
vim.opt.backupdir = os.getenv("HOME") .. "/.local/state/nvim/backup"
vim.opt.swapfile = false

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