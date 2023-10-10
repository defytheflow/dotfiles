---@diagnostic disable: missing-fields
require("bufferline").setup {
  options = {
    always_show_bufferline = false,
    numbers = "ordinal",
    separator_style = "thick",
    diagnostics = "nvim_lsp",
    offsets = {
      {
        filetype = "NvimTree",
      }
    }
  }
}
