-- Defer setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  ---@diagnostic disable-next-line: missing-fields
  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "c",
      "lua",
      "vim",
      "vimdoc",
      "javascript",
      "jsdoc",
      "typescript",
      "php",
      "phpdoc",
      "python",
      "tsx",
      "json",
      "bash",
      "css",
      "sql",
      "html",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
      enable = true,
    },

    -- Needed because treesitter highlight turns off autoindent for php files
    indent = {
      enable = true,
    },

    autotag = {
      enable = true,
      enable_close_on_slash = false,
    },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },

    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          ["aC"] = "@conditional.outer",
          ["iC"] = "@conditional.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- Whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]f"] = "@function.outer",
          ["]]"] = "@class.outer",
          ["]l"] = "@loop.outer",
          ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
          ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
          ["]C"] = "@conditional.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[f"] = "@function.outer",
          ["[["] = "@class.outer",
          ["[l"] = "@loop.outer",
          ["[s"] = { query = "@scope", query_group = "locals", desc = "Previous scope" },
          ["[z"] = { query = "@fold", query_group = "folds", desc = "Previous fold" },
          ["[C"] = "@contitional.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["]A"] = "@parameter.inner",
          ["]F"] = "@function.outer",
        },
        swap_previous = {
          ["[A"] = "@parameter.inner",
          ["[F"] = "@function.outer",
        },
      },
    },
  }

  vim.keymap.set("n", "<leader>ct", function()
    vim.cmd.TSContextToggle()
  end, { desc = "[C]ontext [T]oggle" })

  vim.keymap.set("n", "<leader>cg", function()
    require("treesitter-context").go_to_context()
  end, { desc = "[C]ontext [G]o" })

   vim.g.skip_ts_context_commentstring_module = true

  -- To use for text objects
  local vim_unimpaired_mappings = { "[C", "[CC", "]C", "]CC", "[A", "]A", "[f", "]f" }
  for _, mapping in ipairs(vim_unimpaired_mappings) do
    vim.cmd.unmap(mapping)
  end
end, 0)
