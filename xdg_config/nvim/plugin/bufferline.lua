require("bufferline").setup {
  options = {
    always_show_bufferline = false,
    numbers = "buffer_id",
    diagnostics = "coc",
    separator_style = "thick",
    offsets = {
      {
        filetype = "NvimTree",
      }
    }
  }
}
