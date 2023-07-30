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
    offsets = {
      {
        filetype = 'NvimTree',
      }
    }
  }
})
