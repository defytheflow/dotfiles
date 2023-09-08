-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup {
  -- Game to practice basic vim movements
  "ThePrimeagen/vim-be-good",

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
  { "prichrd/netrw.nvim", dependencies = "nvim-tree/nvim-web-devicons" },

  -- Highlight trailing whitespace
  "echasnovski/mini.trailspace",

  -- Generate JSDoc comments
  {  "heavenshell/vim-jsdoc", build = "make install" },

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

  -- Git commit browser
  { "junegunn/gv.vim", dependencies = "tpope/vim-fugitive" },

  -- Display available keymaps
  { "folke/which-key.nvim", event = "VeryLazy" },

  -- Zen mode
  "folke/zen-mode.nvim",

  -- Dim inactive portions of the code
  "folke/twilight.nvim",

  -- Outline window
  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },

   -- Terminal toggle
  { "akinsho/toggleterm.nvim", version = "*", config = true },

   -- Buffer line
  { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },

  -- Indent guides
  "lukas-reineke/indent-blankline.nvim",

  -- Colorschemes
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  "tanvirtin/monokai.nvim",
  "arzg/vim-colors-xcode",

  -- Status line.
  -- NOTE: because of this plugin, default dashboard page disappears
  { "nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons" },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-context",
      "JoosepAlviste/nvim-ts-context-commentstring",
      -- "windwp/nvim-ts-autotag", -- NOTE: Adds closing jsx tags every time I hit /, event if the tag is already completed and I am editing within it.
    },
  },

  -- Fuzzy finder
  {
     "nvim-telescope/telescope.nvim",
     tag = "0.1.2",
     dependencies = {
       "nvim-lua/plenary.nvim",
       "fannheyward/telescope-coc.nvim",
       "xiyaowong/telescope-emoji.nvim",
    },
  },

  -- Todo comments
  { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- LSP, completion, diagnostics, refactoring, snippets
  {
    "neoclide/coc.nvim", branch = "release",
    dependencies = {
      "neoclide/coc-tsserver",
      "neoclide/coc-highlight",
      "neoclide/coc-snippets",
      "neoclide/coc-json",
      "honza/vim-snippets",
    },
  },

  -- Linting and formatting
  -- "dense-analysis/ale",

  -- Defines camelCase and snake_keys motions (w, b, e)
  -- "bkad/CamelCaseMotion",
  -- let g:camelcasemotion_key = '<leader>'

  -- TODO: what are these for?
  "godlygeek/tabular",
  "preservim/vim-markdown",

  -- Preview markdown in the browser
  {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function() vim.fn["mkdp#util#install"]() end,
  },

  -- Emoji abbreviations, digraphs and completion
  "https://gitlab.com/gi1242/vim-emoji-ab.git",

  -- Automatically inserts the closing tag.
  -- Plug 'alvan/vim-closetag'
  -- let g:closetag_filenames = '*.html,*.xhtml,*.jsx,*.tsx'
  -- let g:closetag_filetypes = 'html,xhtml,jsx'
  -- " let g:closetag_close_shortcut = '<leader>>'
  -- let g:closetag_regions =  {
  -- \ 'typescript.tsx': 'jsxRegion,tsxRegion',
  -- \ 'javascript.jsx': 'jsxRegion',
  -- \ }

  -- Aligns text
  "junegunn/vim-easy-align",
  -- let g:easy_align_ignore_groups = []
  -- xmap ga <Plug>(EasyAlign)
  -- nmap ga <Plug>(EasyAlign)


  -- Highlights unique characters in every word to easier use f, F, t and T
  {
    "unblevable/quick-scope",
    config = function()
      -- TODO: doesn't work
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    end
  },
  -- let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

  --  Emmet support.
  --  Plug 'mattn/emmet-vim'
  --  uses <C-Y> which conflicts with vim built-in

  "AndrewRadev/tagalong.vim",  -- Auto rename closing/opening tags
  "vim-test/vim-test",         -- Run tests
  "voldikss/vim-floaterm",     -- Display a floating terminal
  "vimwiki/vimwiki",           -- Personal wiki
  "cohama/lexima.vim",         -- Auto close quotes and parentheses.
  "tpope/vim-projectionist",   -- Switch between alternative files
  "tpope/vim-commentary",      -- Comment stuff out with `gc`
  "tpope/vim-repeat",          -- Enable repeating plugin mappings with \"."
  "tpope/vim-surround",        -- Delete/change/add parentheses/quotes/tags
  "tpope/vim-unimpaired",      -- Pairs of handy bracket mappings

  -- Python text objects and motions.
  { "jeetsukumaran/vim-pythonsense", ft = "python" },

  -- Python indentation that complies with pep8.
  {
    "Vimjas/vim-python-pep8-indent",
    ft = "python",
    config = function()
      -- TODO: doesn't work
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
  "tomasiser/vim-code-dark",
  "tomasr/molokai",
  "morhetz/gruvbox",
  "chriskempson/base16-vim",
  "haishanh/night-owl.vim",
  { "kaicataldo/material.vim", branch = "main" },

  -- Syntaxes
  "mboughaba/i3config.vim",
  { "uiiaoo/java-syntax.vim", ft = "java" },
  { "octol/vim-cpp-enhanced-highlight", ft = "cpp" },
  { "cespare/vim-toml", ft = "toml" },
  "pantharshit00/vim-prisma",
}
