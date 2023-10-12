require("ibl").setup {
  indent = { char = "¦" },
  scope = {
   enabled = false,
  },
  exclude = {
    filetypes = {
      -- defaults
      "lspinfo",
      "packer",
      "checkhealth",
      "help",
      "man",
      "gitcommmit",
      "TelescopePrompt",
      "TelescopeResults",
      "",
      -- custom
      "text",
      "vimwiki",
      "dashboard",
    }
  },
}

local hooks = require("ibl.hooks")
hooks.register(
  hooks.type.WHITESPACE,
  hooks.builtin.hide_first_space_indent_level
)
