vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.listchars:append { tab = "  " }

vim.opt_local.makeprg = "go run %"

vim.keymap.set("n", "<leader>mk", function()
  vim.cmd.write()
  local module_root = vim.fs.root(0, "go.mod")
  local command
  if module_root then
    command = "go -C " .. vim.fn.shellescape(module_root) .. " run ."
  else
    command = "go run " .. vim.fn.shellescape(vim.fn.expand("%:p"))
  end
  require("toggleterm").exec(command, nil, nil, nil, nil, nil, false)
end, { buffer = true, desc = "[M]a[k]e Go module or file" })

vim.keymap.set("n", "<leader>mt", function()
  vim.cmd.write()
  local directory = vim.fs.root(0, "go.mod") or vim.fn.expand("%:p:h")
  local command = "go -C " .. vim.fn.shellescape(directory) .. " test -v"
  require("toggleterm").exec(command, nil, nil, nil, nil, nil, false)
end, { buffer = true, desc = "[M]ake Go [T]ests" })
