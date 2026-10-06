local function open_in_arcanum()
  local file = vim.api.nvim_buf_get_name(0)
  if file == "" or vim.bo.buftype ~= "" then
    vim.notify("Open a file to view its line in Arcanum", vim.log.levels.WARN)
    return
  end
  if vim.fn.executable("arc") ~= 1 then
    vim.notify("Arc executable not found", vim.log.levels.ERROR)
    return
  end

  local line = vim.api.nvim_win_get_cursor(0)[1]
  vim.system({ "arc", "root" }, {
    cwd = vim.fs.dirname(file),
    text = true,
    timeout = 2000,
  }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        vim.notify("Cannot determine Arc root: " .. vim.trim(result.stderr or ""), vim.log.levels.ERROR)
        return
      end

      local root = vim.trim(result.stdout or "")
      local relpath = root ~= "" and vim.fs.relpath(root, file) or nil
      if not relpath then
        vim.notify("Cannot resolve the file path relative to Arc root", vim.log.levels.ERROR)
        return
      end

      local url = "https://a.yandex-team.ru/arcadia/" .. vim.uri_encode(relpath) .. "#L" .. line
      local _, err = vim.ui.open(url)
      if err then vim.notify(err, vim.log.levels.ERROR) end
    end)
  end)
end

vim.api.nvim_create_user_command("OpenInArcanum", open_in_arcanum, {
  desc = "Open current line in Arcanum",
})

if require("defytheflow.vcs").is_arc_repo() then
  vim.keymap.set("n", "<leader>ao", "<Cmd>OpenInArcanum<CR>", { desc = "[A]rcanum [O]pen line" })
end
