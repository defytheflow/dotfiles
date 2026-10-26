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

      if err then
        vim.notify(err, vim.log.levels.ERROR)
      end
    end)
  end)
end

vim.api.nvim_create_user_command("OpenInArcanum", open_in_arcanum, {
  desc = "Open current line in Arcanum",
})

local function open_line_pr()
  local file = vim.api.nvim_buf_get_name(0)

  if file == "" or vim.bo.buftype ~= "" then
    vim.notify("Open a file to find its line's PR", vim.log.levels.WARN)
    return
  end

  if vim.bo.modified then
    vim.notify("Save the file before looking up its line's PR", vim.log.levels.WARN)
    return
  end

  if vim.fn.executable("arc") ~= 1 then
    vim.notify("Arc executable not found", vim.log.levels.ERROR)
    return
  end

  local line = vim.api.nvim_win_get_cursor(0)[1]
  local text = vim.api.nvim_get_current_line()

  vim.system({ "arc", "blame", "--json", "-L", line .. "," .. line, vim.fs.basename(file) }, {
    cwd = vim.fs.dirname(file),
    text = true,
    timeout = 10000,
  }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        vim.notify("Cannot read Arc blame: " .. vim.trim(result.stderr or ""), vim.log.levels.ERROR)
        return
      end

      local ok, blame = pcall(vim.json.decode, result.stdout or "")
      local annotation = ok and type(blame) == "table" and blame.annotation and blame.annotation[1]

      if not annotation or (annotation.text or ""):gsub("\r?\n$", "") ~= text then
        vim.notify("No committed blame found for this line", vim.log.levels.WARN)
        return
      end

      for _, commit in ipairs(blame.commits or {}) do
        if commit.commit == annotation.commit then
          -- Arc supplies the PR attribute; older commits may only have a REVIEW trailer.
          local pr = (commit.attributes or {})["pr.id"]
            or ("\n" .. (commit.message or "")):match("\nREVIEW:%s*(%d+)")

          if pr and tostring(pr):match("^%d+$") then
            local _, err = vim.ui.open("https://a.yandex-team.ru/review/" .. pr .. "/details")

            if err then
              vim.notify(err, vim.log.levels.ERROR)
            end

            return
          end
        end
      end

      vim.notify("No PR linked to this line's commit", vim.log.levels.INFO)
    end)
  end)
end

vim.api.nvim_create_user_command("OpenLinePR", open_line_pr, {
  desc = "Open the PR that last changed the current line",
})

if require("defytheflow.vcs").is_arc_repo() then
  vim.keymap.set("n", "<leader>ao", "<Cmd>OpenInArcanum<CR>", { desc = "[A]rcanum [O]pen line" })
  vim.keymap.set("n", "<leader>aP", "<Cmd>OpenLinePR<CR>", { desc = "[A]rcanum line [P]R" })
end
