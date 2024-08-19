-- Disables query results folding by default
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dbout",
  command = "setlocal nofoldenable",
})

-- Enables table column names autocompletion
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sql,mysql,plsql",
  callback = function()
    require("cmp").setup.buffer {
      sources = {
        { name = "vim-dadbod-completion" },
      },
    }
  end
})

vim.keymap.set("n", "<leader>d", vim.cmd.DBUIToggle)

