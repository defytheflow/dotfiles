-- Status line.
require('lualine').setup()

-- Fuzzy finder.
local actions = require("telescope.actions")
require('telescope').setup({
  defaults = {
    file_ignore_patterns = { ".git/*" },
  },
  pickers = {
    find_files = {
      hidden = true;
    }
  }
})
require("telescope").load_extension("emoji")
require('telescope').load_extension('coc')

-- Indent guides.
-- require("indent_blankline").setup ({
--   -- char = '¦',
--   show_trailing_blankline_indent = false,
--   -- show_first_indent_level = false,
--   use_treesitter = true,
--   -- show_current_context = true,
--   -- show_current_context_start = true,
--   filetype_exclude = {
--     -- defaults
--     "lspinfo",
--     "packer",
--     "checkhealth",
--     "help",
--     "man",
--     "",
--     -- custom
--     "text",
--     "vimwiki",
--   },
-- })

-- Terminal toggle.
-- require('toggleterm').setup({
--   open_mapping = [[<c-\>]],
--   -- shade_terminals = false,
-- })

-- Todo comments.
require('todo-comments').setup()

-- Netrw file icons.
require('netrw').setup()

-- Outline window.
require('aerial').setup({
  autojump = true,
  layout = {
    -- default_direction = "prefer_left"
  }
})

-- Displays available keybindings.
require('which-key').setup()

-- Dashboard.
require('dashboard').setup({
    theme = 'hyper',
    config = {
      week_header = {
       enable = true,
      },
      shortcut = {
        { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
        {
          icon = ' ',
          icon_hl = '@variable',
          desc = 'Files',
          group = 'Label',
          action = 'Telescope find_files',
          key = 'f',
        },
        {
          desc = ' Apps',
          group = 'DiagnosticHint',
          action = 'Telescope app',
          key = 'a',
        },
        {
          desc = ' dotfiles',
          group = 'Number',
          action = 'Telescope dotfiles',
          key = 'd',
        },
      },
    },
})

-- Highlight trailing whitespace
require('mini.trailspace').setup()

-- Disable highlighting on dashboard page
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dashboard',
  callback = function(data)
    vim.b[data.buf].minitrailspace_disable = true
    vim.api.nvim_buf_call(data.buf, MiniTrailspace.unhighlight)
  end,
})
