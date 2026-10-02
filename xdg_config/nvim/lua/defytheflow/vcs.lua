local M = {}
local arc_repo

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
