-- Treesitter.
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "c",
    "lua",
    "vim",
    "vimdoc",
    "javascript",
    "typescript",
    "python",
    "tsx",
    "json",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },

  context_commentstring = {
    enable = true,
  },

  autotag = {
    enable = true,
  }
})

-- Buffer line.
require("bufferline").setup({
  options = {
    always_show_bufferline = false,
    numbers = "buffer_id",
    diagnostics = "coc",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = e == "error" and " " or (e == "warning" and " " or "" )
        s = s .. sym .. n
      end
      return s
    end,
    separator_style = "thick",
  }
})

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
    default_direction = "prefer_left"
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
