require("toggleterm").setup {
  open_mapping = [[<c-\>]],
}

-- vim.keymap.set("n", "<leader>\\", function()
--   require("toggleterm").toggle()
-- end, { desc = "[/] Toggle Terminal" })

-- TODO: toggle terminal position between horizontal and vertical
-- TODO: switch focus between terminal and editor with terminal still being here

vim.keymap.set(
  "n",
  "<leader>mk",
  function()
    local makeprg = vim.bo.makeprg
    vim.cmd.write()
    vim.cmd("TermExec cmd='" .. makeprg .. "' go_back=0")
  end,
  { desc = "[M]a[k]e" }
)
