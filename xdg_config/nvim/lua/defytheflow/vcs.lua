local M = {}
local arc_repo

-- Check whether Neovim's working directory is inside an Arc repository.
-- This lets the config choose Arc integrations instead of Git integrations.
function M.is_arc_repo()
  if arc_repo ~= nil then return arc_repo end

  arc_repo = false
  if vim.fn.isdirectory(vim.fn.expand("~/arcadia")) ~= 1 then return arc_repo end
  if vim.fn.executable("arc") ~= 1 then return arc_repo end

  vim.fn.system({ "arc", "root" })
  arc_repo = vim.v.shell_error == 0
  return arc_repo
end

return M
