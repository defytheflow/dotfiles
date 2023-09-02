require("indent_blankline").setup {
  -- char = "¦",
  show_trailing_blankline_indent = false,
  -- show_first_indent_level = false,
  use_treesitter = true,
  -- show_current_context = true,
  -- show_current_context_start = true,
  filetype_exclude = {
    -- defaults
    "lspinfo",
    "packer",
    "checkhealth",
    "help",
    "man",
    "",
    -- custom
    "text",
    "vimwiki",
    "dashboard",
  },
}
