local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: FiraCode Nerd Font makes all the icons inside neovim work.

-- NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- NOTE: `opts = {}` is the same as calling `require('some-plugin').setup({})`
require("lazy").setup {
  -- Game to practice basic vim movements
  "ThePrimeagen/vim-be-good",

  -- Switch between themes with persistence
  {
    "zaldih/themery.nvim",
    lazy = false,
    config = function()
      require("themery").setup({
        themes = {
          "catppuccin",
          "tokyonight-moon",
          "base16-classic-dark",
          "base16-gruvbox-dark-hard",
          "base16-ocean",
          "night-owl",
          "xcode",
          "monokai",
        }
      })
    end
  },

  { "petertriho/nvim-scrollbar", opts = {} },

  { 'danilamihailov/beacon.nvim' },

  { "marilari88/twoslash-queries.nvim" },

  -- Debugger
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI for debugger
      { "rcarriga/nvim-dap-ui", opts = {} },
      "nvim-neotest/nvim-nio",

      -- Displays variable values as a virtual text
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {
          commented = true,
        },
      },
    },
  },

  -- Overlays '*' characters over values inside .env files
  { "laytan/cloak.nvim", opts = {} },

  -- Tree explorer that allows editing through text manipulating in a buffer
  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = false, -- without this, disables :Ex command for opening netrw
      skip_confirm_for_simple_edits = true,
    },
    init = function()
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end
  },

  -- Database viewer
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
  },

  -- Flake8 linting and Autoformatting on save
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- NOTE: breaks treesitter-context
  -- Dims inactive windows
  -- {
  --   "sunjon/Shade.nvim",
  --   opts = {
  --     overlay_opacity = 40,
  --   },
  -- },

  {
    "prettier/vim-prettier",
    run = "yarn install --frozen-lockfile --production",
    ft = {"javascript", "typescript", "javascriptreact", "typescriptreact", "css", "scss", "json", "graphql", "markdown", "vue", "yaml", "html"},
    config = function()
      vim.g["prettier#exec_cmd_async"] = 1
    end
  },

  -- Marks per project
  {
    "ThePrimeagen/harpoon",
    dependencies = "nvim-lua/plenary.nvim",
  },

  -- Highlight colors
  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      enable_tailwind = true,
    },
  },

  -- Open files at last edit location
  "farmergreg/vim-lastplace",

  -- Undo history visualizer
  "mbbill/undotree",

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = "nvim-tree/nvim-web-devicons"
  },

  -- Netrw file icons
  {
    "prichrd/netrw.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
  },

  -- Highlight trailing whitespace
  {
    "ntpeters/vim-better-whitespace",
    init = function()
      vim.g.better_whitespace_filetypes_blacklist = {
        -- defaults
        "diff", "git", "gitcommit", "unite", "qf", "help", "markdown", "fugitive",
        -- custom
        "dashboard", "toggleterm",
      }
      vim.g.better_whitespace_guicolor = "#f38ba8"
    end
  },

  -- Generate JSDoc comments
  { "heavenshell/vim-jsdoc", build = "make install" },

  -- Start screen
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = "nvim-tree/nvim-web-devicons",
  },

  -- Git signs/decorations
  "lewis6991/gitsigns.nvim",

  -- Git plugin
  "tpope/vim-fugitive",

  -- Github plugin
  "tpope/vim-rhubarb",

  -- Git commit browser
  { "junegunn/gv.vim", dependencies = "tpope/vim-fugitive" },

  -- Display available keymaps
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- Don't show a warning on start up when issues were detected with the mappings
      notify = false,
    },
  },

  -- Zen mode
  "folke/zen-mode.nvim",

  -- Dim inactive portions of the code
  {
    "folke/twilight.nvim",
    opts = {
      context = 20,
      -- TODO: dim out everything except current active function
      -- expand = { "function", "method" }
    },
  },

  -- Outline window
  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },

  -- Terminal toggle
  { "akinsho/toggleterm.nvim", version = "*", config = true, },

  -- Buffer line
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons"
  },

  -- Indent guides
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  -- Commenting plugin
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup {
        -- enable jsx, tsx commenting support
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()
      }
    end,
    init = function()
      -- to make gcc '--' comments work in in DBUI query buffer for MySQL
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "mysql",
        command = "setlocal commentstring=--\\ %s",
      })
    end,
  },

  -- Status line (because of this plugin default dashboard page disappears)
  {
    "nvim-lualine/lualine.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {},
  },

  -- LSP configuration & plugins
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      {
        "j-hui/fidget.nvim",
        tag = "v1.4.5",
        opts = {
          progress = {
            ignore = {
              -- phpactor spams "Code actions resolved"
              -- "Resolving code actions" message on almost every key stroke in normal mode
              "phpactor",
            },
          },
        },
      },

      -- Neovim setup for init.lua and plugin development with full signature help, docs
      -- and completion for the nvim lua API.
      "folke/neodev.nvim",

      -- More LSP actions, alternative UI
      "nvimdev/lspsaga.nvim",

      -- LSP renaming with immediate visual feedback
      { "smjonas/inc-rename.nvim", opts = {} },
    },
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",

      -- Snippet engine, its associated nvim-cmp source and some user-friendly snippets
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",

      -- Buffer words and filesystem paths
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
    },
  },

  -- Pretty list of showing diagnostics, references, telescope results, quickfix and location lists.
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- Highlight, edit and navigate code
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      {  "nvim-treesitter/nvim-treesitter-context", opts = { enable = true } },
      "JoosepAlviste/nvim-ts-context-commentstring",
      -- NOTE: Adds closing jsx tags every time I hit /, even if the tag is already
      -- completed and I am editing within it.
      "windwp/nvim-ts-autotag",
    },
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    dependencies = {
      "nvim-lua/plenary.nvim",

      -- Fuzzy finder algorithm
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },

      "xiyaowong/telescope-emoji.nvim",
    },
  },

  -- Todo comments
  { "folke/todo-comments.nvim", dependencies = "nvim-lua/plenary.nvim" },

  -- LSP, completion, diagnostics, refactoring, snippets
  -- {
  --   "neoclide/coc.nvim",
  --   branch = "release",
  --   dependencies = {
  --     "neoclide/coc-tsserver",
  --     "neoclide/coc-highlight",
  --     "neoclide/coc-json",
  --     "neoclide/coc-css",
  --     "neoclide/coc-snippets",
  --     "honza/vim-snippets",
  --   },
  --   config = function()
  --     require("plugin.coc")
  --   end
  -- },

  -- Defines camelCase and snake_keys motions (w, b, e)
  -- {
  --   "bkad/CamelCaseMotion",
  --   init = function()
  --     vim.g.camelcasemotion_key = "<leader>"
  --   end
  -- },

  {
    "preservim/vim-markdown",
    ft = "markdown",
    dependencies = "godlygeek/tabular",
  },

  -- Preview markdown in the browser
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Emoji abbreviations, digraphs and completion
  "https://gitlab.com/gi1242/vim-emoji-ab.git",

  -- Automatically insert the closing tag
  -- {
  --   "alvan/vim-closetag",
  --   init = function()
  --     vim.g.closetag_filenames = "*.html,*.xhtml,*.jsx,*.tsx"
  --     vim.g.closetag_filetypes = "html,xhtml,jsx"
  --     vim.g.closetag_regions = {
  --       ["typescript.tsx"] = "jsxRegion,tsxRegion",
  --       ["javascript.jsx"] = "jsxRegion",
  --     }
  --   end
  -- },

  -- Align text
  {
    "junegunn/vim-easy-align",
    init = function()
      vim.g.easy_align_ignore_groups = {}
      vim.keymap.set("x", "ga", "<Plug>(EasyAlign)")
      vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")
    end
  },

  -- Highlight unique characters in every word to easier use f, F, t and T
  {
    "unblevable/quick-scope",
    init = function()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    end
  },

  --  Emmet support.
  -- "mattn/emmet-vim"
  --  uses <C-Y> which conflicts with vim built-in

  "AndrewRadev/tagalong.vim", -- Auto rename closing/opening tags
  "vim-test/vim-test",        -- Run tests
  "voldikss/vim-floaterm",    -- Display a floating terminal
  "vimwiki/vimwiki",          -- Personal wiki
  "cohama/lexima.vim",        -- Auto close quotes and parentheses.
  "tpope/vim-projectionist",  -- Switch between alternative files
  -- "tpope/vim-commentary",     -- Comment stuff out with `gc`
  "tpope/vim-repeat",         -- Enable repeating plugin mappings with \"."
  "tpope/vim-surround",       -- Delete/change/add parentheses/quotes/tags
  "tpope/vim-unimpaired",     -- Pairs of handy bracket mappings

  -- Python indentation that complies with pep8
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
    init = function()
      vim.g.python_pep8_indent_hang_closing = 0
    end,
  },

  -- Text object for entire buffer
  { "kana/vim-textobj-entire", dependencies = "kana/vim-textobj-user" },

  -- Text object for lines at the same indent level
  "michaeljsmith/vim-indent-object",

  -- Text objects like `i/`
  "wellle/targets.vim",

  -- Colorschemes
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    -- config = function() vim.cmd.colorscheme("tokyonight-moon") end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function() vim.cmd.colorscheme("catppuccin") end
  },
  "tanvirtin/monokai.nvim",
  "arzg/vim-colors-xcode",
  "haishanh/night-owl.vim",
  {
    "chriskempson/base16-vim",
    config = function()
      -- Good ones
      -- vim.cmd.colorscheme("base16-classic-dark")
      -- vim.cmd.colorscheme("base16-gruvbox-dark-hard")
      -- vim.cmd.colorscheme("base16-ocean")
    end
  },
  "morhetz/gruvbox",
}

require("defytheflow.settings")
require("defytheflow.keymaps")
require("defytheflow.autocmds")
require("defytheflow.digraphs")
