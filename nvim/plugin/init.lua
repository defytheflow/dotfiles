-- Treesitter.
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "c",
    "lua",
    "vim",
    "help",
    "javascript",
    "typescript",
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
})

-- Buffer line.
-- require("bufferline").setup({
--   options = {
--     always_show_bufferline = false,
--     numbers = "buffer_id",
--     diagnostics = "coc",
--     diagnostics_indicator = function(count, level, diagnostics_dict, context)
--       local s = " "
--       for e, n in pairs(diagnostics_dict) do
--         local sym = e == "error" and " " or (e == "warning" and " " or "" )
--         s = s .. sym .. n
--       end
--       return s
--     end,
--     separator_style = "thick",
--   }
-- })

-- Status line.
require('lualine').setup()

-- Fuzzy finder.
require("telescope").load_extension("emoji")
require('telescope').load_extension('coc')

-- Terminal toggle.
require('toggleterm').setup({
  open_mapping = [[<c-\>]],
  -- shade_terminals = false,
})
