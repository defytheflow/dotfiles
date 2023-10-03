require("ibl").setup {
  indent = { char = "¦" },
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
