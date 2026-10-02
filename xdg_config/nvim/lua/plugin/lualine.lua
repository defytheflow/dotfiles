local M = {}
local branch = ""
local refreshing = false

function M.opts()
  if not require("defytheflow.vcs").is_arc_repo() then return {} end

  local group = vim.api.nvim_create_augroup("vimrc_arc_branch", { clear = true })
  vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "ShellCmdPost" }, {
    group = group,
    callback = M.refresh_branch,
  })
  M.refresh_branch()

  return {
    sections = {
      lualine_b = {
        { function() return branch end, icon = "" },
        "diff",
        "diagnostics",
      },
    },
  }
end

function M.refresh_branch()
  if refreshing then return end
  refreshing = true

  vim.system({ "arc", "info", "--json" }, { text = true, timeout = 2000 }, function(result)
    vim.schedule(function()
      refreshing = false
      branch = ""
      if result.code == 0 then
        local ok, info = pcall(vim.json.decode, result.stdout)
        if ok and type(info) == "table" and type(info.branch) == "string" then
          branch = info.branch
        end
      end
      require("lualine").refresh({ place = { "statusline" } })
    end)
  end)
end

return M
