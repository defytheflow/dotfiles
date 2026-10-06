local M = {}

local stage_history = {}

local get_buffer_context
local get_hunk_context
local get_arc_context
local read_index
local read_revision
local stage_content
local split_text
local join_lines
local select_hunk
local find_hunk
local apply_hunk
local revert_hunk
local buffer_line_to_index
local hunk_touches_eof
local reset_staged_hunk
local same_hunk
local refresh
local notify

function M.stage_hunk(range)
  local context, context_error = get_hunk_context(range)
  if not context then
    notify(context_error, vim.log.levels.WARN)
    return
  end

  local staged_lines = apply_hunk(context.index_lines, context.buffer_lines, context.hunk)
  local staged_has_eol = hunk_touches_eof(context.hunk, #context.buffer_lines)
      and context.buffer_has_eol
    or context.index_has_eol
  local before = join_lines(context.index_lines, context.index_has_eol)
  local after = join_lines(staged_lines, staged_has_eol)
  local stage_error = stage_content(context, after)

  if stage_error then
    notify(stage_error, vim.log.levels.ERROR)
    return
  end

  stage_history[context.bufnr] = stage_history[context.bufnr] or {}
  table.insert(stage_history[context.bufnr], {
    arc = context.arc,
    before = before,
    after = after,
    hunk = vim.deepcopy(context.hunk),
    buffer_line_count = #context.buffer_lines,
  })
  refresh()
  notify("Staged Arc hunk")
end

function M.reset_hunk(range)
  local context, context_error = get_hunk_context(range)
  if not context then
    local reset, staged_error = reset_staged_hunk(range)
    if reset then return end

    notify(staged_error or context_error, vim.log.levels.WARN)
    return
  end

  local hunk = context.hunk
  local replacement = {}
  for i = hunk[1], hunk[1] + hunk[2] - 1 do
    replacement[#replacement + 1] = context.index_lines[i]
  end

  local buffer_start = hunk[3] - (hunk[4] > 0 and 1 or 0)
  vim.api.nvim_buf_set_lines(
    context.bufnr,
    buffer_start,
    buffer_start + hunk[4],
    false,
    replacement
  )

  if hunk_touches_eof(hunk, #context.buffer_lines) then
    vim.bo[context.bufnr].endofline = context.index_has_eol
  end

  local line_count = vim.api.nvim_buf_line_count(context.bufnr)
  vim.api.nvim_win_set_cursor(0, { math.min(math.max(buffer_start + 1, 1), line_count), 0 })
  refresh()
  notify("Reset Arc hunk")
end

function M.unstage_hunk(range)
  local context, context_error = get_buffer_context()
  if not context then
    notify(context_error, vim.log.levels.WARN)
    return
  end

  local unstaged_hunks = vim.diff(
    join_lines(context.index_lines, context.index_has_eol),
    join_lines(context.buffer_lines, context.buffer_has_eol),
    { result_type = "indices", algorithm = "histogram" }
  )
  local cursor_line = buffer_line_to_index(
    unstaged_hunks,
    vim.api.nvim_win_get_cursor(0)[1]
  )
  local index_range
  if range then
    table.sort(range)
    local range_start = buffer_line_to_index(unstaged_hunks, range[1])
    local range_end = buffer_line_to_index(unstaged_hunks, range[2])
    if not range_start or not range_end then
      notify("Selected lines contain unstaged changes; stage them before unstaging", vim.log.levels.WARN)
      return
    end
    index_range = { range_start, range_end }
  elseif not cursor_line then
    notify("Current line contains unstaged changes", vim.log.levels.WARN)
    return
  end

  local head_text, head_error = read_revision(context.arc, "HEAD")
  if not head_text then
    notify(head_error, vim.log.levels.ERROR)
    return
  end

  local head_lines, head_has_eol = split_text(head_text)
  local staged_hunks = vim.diff(
    join_lines(head_lines, head_has_eol),
    join_lines(context.index_lines, context.index_has_eol),
    { result_type = "indices", algorithm = "histogram" }
  )
  local hunk = select_hunk(staged_hunks, cursor_line or index_range[1], index_range)
  if not hunk then
    notify("No staged Arc hunk in the selected range", vim.log.levels.WARN)
    return
  end

  local unstaged_lines = revert_hunk(head_lines, context.index_lines, hunk)
  local unstaged_has_eol = hunk_touches_eof(hunk, #context.index_lines)
      and head_has_eol
    or context.index_has_eol
  local stage_error = stage_content(context, join_lines(unstaged_lines, unstaged_has_eol))
  if stage_error then
    notify(stage_error, vim.log.levels.ERROR)
    return
  end

  stage_history[context.bufnr] = {}
  refresh()
  notify("Unstaged Arc hunk")
end

function M.unstage_buffer()
  local context, context_error = get_buffer_context()
  if not context then
    notify(context_error, vim.log.levels.WARN)
    return
  end

  local head_text, head_error = read_revision(context.arc, "HEAD")
  if not head_text then
    notify(head_error, vim.log.levels.ERROR)
    return
  end

  local index_text = join_lines(context.index_lines, context.index_has_eol)
  if index_text == head_text then
    notify("No staged Arc changes in the buffer", vim.log.levels.WARN)
    return
  end

  local stage_error = stage_content(context, head_text)
  if stage_error then
    notify(stage_error, vim.log.levels.ERROR)
    return
  end

  stage_history[context.bufnr] = {}
  refresh()
  notify("Unstaged Arc buffer")
end

function M.stage_buffer()
  local context, context_error = get_buffer_context()
  if not context then
    notify(context_error, vim.log.levels.WARN)
    return
  end

  local index_text = join_lines(context.index_lines, context.index_has_eol)
  local buffer_text = join_lines(context.buffer_lines, context.buffer_has_eol)
  if index_text == buffer_text then
    notify("No unstaged Arc changes in the buffer", vim.log.levels.WARN)
    return
  end

  local stage_error = stage_content(context, buffer_text)
  if stage_error then
    notify(stage_error, vim.log.levels.ERROR)
    return
  end

  stage_history[context.bufnr] = {}
  refresh()
  notify("Staged Arc buffer")
end

function M.undo_stage_hunk()
  local bufnr = vim.api.nvim_get_current_buf()
  local history = stage_history[bufnr]
  local entry = history and history[#history]
  if not entry then
    notify("No Arc hunks staged from this buffer to undo", vim.log.levels.WARN)
    return
  end

  local current_index, read_error = read_index(entry.arc)
  if not current_index then
    notify(read_error, vim.log.levels.ERROR)
    return
  end

  if current_index ~= entry.after then
    notify("Arc index changed after staging; refusing to overwrite it", vim.log.levels.ERROR)
    return
  end

  local stage_error = stage_content({ arc = entry.arc }, entry.before)
  if stage_error then
    notify(stage_error, vim.log.levels.ERROR)
    return
  end

  table.remove(history)
  refresh()
  notify("Undid staged Arc hunk")
end

function M.reset_buffer()
  local context, context_error = get_buffer_context()
  if not context then
    notify(context_error, vim.log.levels.WARN)
    return
  end

  local index_text = join_lines(context.index_lines, context.index_has_eol)
  local buffer_text = join_lines(context.buffer_lines, context.buffer_has_eol)
  if index_text == buffer_text then
    notify("No unstaged Arc changes in the buffer", vim.log.levels.WARN)
    return
  end

  vim.api.nvim_buf_set_lines(context.bufnr, 0, -1, false, context.index_lines)
  vim.bo[context.bufnr].endofline = context.index_has_eol
  refresh()
  notify("Reset Arc buffer")
end

get_buffer_context = function()
  local bufnr = vim.api.nvim_get_current_buf()
  local file = vim.api.nvim_buf_get_name(bufnr)

  if file == "" or vim.bo[bufnr].buftype ~= "" then
    return nil, "Current buffer is not a file"
  end

  local arc, arc_error = get_arc_context(file)
  if not arc then return nil, arc_error end

  local index_text, index_error = read_index(arc)
  if not index_text then return nil, index_error end

  local index_lines, index_has_eol = split_text(index_text)
  return {
    arc = arc,
    bufnr = bufnr,
    index_lines = index_lines,
    index_has_eol = index_has_eol,
    buffer_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false),
    buffer_has_eol = vim.bo[bufnr].endofline,
  }
end

get_hunk_context = function(range)
  local context, context_error = get_buffer_context()
  if not context then return nil, context_error end

  local hunks = vim.diff(
    join_lines(context.index_lines, context.index_has_eol),
    join_lines(context.buffer_lines, context.buffer_has_eol),
    { result_type = "indices", algorithm = "histogram" }
  )
  local hunk = select_hunk(hunks, vim.api.nvim_win_get_cursor(0)[1], range)
  if not hunk then return nil, "No unstaged Arc hunk in the selected range" end

  context.hunk = hunk
  return context
end

get_arc_context = function(file)
  local root_result = vim.system(
    { "arc", "root" },
    { cwd = vim.fs.dirname(file), text = true }
  ):wait()

  if root_result.code ~= 0 then return nil, "Current file is not inside an Arc repository" end

  local root = vim.trim(root_result.stdout or "")
  local relpath = vim.fs.relpath(root, vim.fs.normalize(file))
  if not relpath then return nil, "Cannot resolve the file path relative to Arc root" end

  return { root = root, relpath = relpath }
end

read_index = function(arc)
  return read_revision(arc, "")
end

read_revision = function(arc, revision)
  local result = vim.system(
    { "arc", "show", revision .. ":" .. arc.relpath },
    { cwd = arc.root, text = true }
  ):wait()

  if result.code ~= 0 then
    local source = revision == "" and "index" or revision
    return nil, "Cannot read the file from Arc " .. source
  end

  return result.stdout or ""
end

stage_content = function(context, content)
  local result = vim.system(
    { "arc", "add", context.arc.relpath, "-F", "-" },
    { cwd = context.arc.root, stdin = content, text = true }
  ):wait()

  if result.code == 0 then return end

  local message = vim.trim(result.stderr or "")
  return message ~= "" and message or "Failed to update the Arc index"
end

split_text = function(text)
  local has_eol = text:sub(-1) == "\n"
  if has_eol then text = text:sub(1, -2) end
  if text == "" then return {}, has_eol end

  return vim.split(text, "\n", { plain = true }), has_eol
end

join_lines = function(lines, has_eol)
  local text = table.concat(lines, "\n")
  return has_eol and text .. "\n" or text
end

select_hunk = function(hunks, cursor_line, range)
  if not range then return find_hunk(hunks, cursor_line) end

  table.sort(range)
  local H = require("gitsigns.hunks")
  local gitsigns_hunks = {}
  for _, hunk in ipairs(hunks) do
    gitsigns_hunks[#gitsigns_hunks + 1] = H.create_hunk(unpack(hunk))
  end

  local partial = H.create_partial_hunk(gitsigns_hunks, range[1], range[2])
  if not partial then return end

  return {
    partial.removed.start,
    partial.removed.count,
    partial.added.start,
    partial.added.count,
  }
end

find_hunk = function(hunks, cursor_line)
  for _, hunk in ipairs(hunks) do
    local buffer_start = hunk[3]
    local buffer_count = hunk[4]

    if buffer_count == 0 then
      if cursor_line == math.max(1, buffer_start) then return hunk end
    elseif cursor_line >= buffer_start and cursor_line < buffer_start + buffer_count then
      return hunk
    end
  end
end

apply_hunk = function(index_lines, buffer_lines, hunk)
  local index_start = hunk[1]
  local index_count = hunk[2]
  local buffer_start = hunk[3]
  local buffer_count = hunk[4]
  local result = {}
  local prefix_end = index_start - (index_count > 0 and 1 or 0)
  local suffix_start = index_start + index_count + (index_count == 0 and 1 or 0)

  for i = 1, prefix_end do result[#result + 1] = index_lines[i] end
  for i = buffer_start, buffer_start + buffer_count - 1 do result[#result + 1] = buffer_lines[i] end
  for i = suffix_start, #index_lines do result[#result + 1] = index_lines[i] end

  return result
end

revert_hunk = function(base_lines, target_lines, hunk)
  local base_start = hunk[1]
  local base_count = hunk[2]
  local target_start = hunk[3]
  local target_count = hunk[4]
  local result = {}
  local prefix_end = target_start - (target_count > 0 and 1 or 0)
  local suffix_start = target_start + target_count + (target_count == 0 and 1 or 0)

  for i = 1, prefix_end do result[#result + 1] = target_lines[i] end
  for i = base_start, base_start + base_count - 1 do result[#result + 1] = base_lines[i] end
  for i = suffix_start, #target_lines do result[#result + 1] = target_lines[i] end

  return result
end

buffer_line_to_index = function(hunks, buffer_line)
  local index_line = buffer_line

  for _, hunk in ipairs(hunks) do
    local index_count = hunk[2]
    local buffer_start = hunk[3]
    local buffer_count = hunk[4]

    if buffer_count > 0
        and buffer_line >= buffer_start
        and buffer_line < buffer_start + buffer_count then
      return
    end

    local after_hunk = buffer_count == 0
        and buffer_line > buffer_start
      or buffer_count > 0 and buffer_line >= buffer_start + buffer_count
    if after_hunk then index_line = index_line - (buffer_count - index_count) end
  end

  return index_line
end

hunk_touches_eof = function(hunk, buffer_line_count)
  if hunk[4] == 0 then return hunk[3] >= buffer_line_count end

  return hunk[3] + hunk[4] - 1 >= buffer_line_count
end

reset_staged_hunk = function(range)
  local bufnr = vim.api.nvim_get_current_buf()
  local history = stage_history[bufnr]
  local entry = history and history[#history]
  if not entry then return false end

  local selected = select_hunk(
    { entry.hunk },
    vim.api.nvim_win_get_cursor(0)[1],
    range
  )
  if not selected or range and not same_hunk(selected, entry.hunk) then return false end

  local current_index, read_error = read_index(entry.arc)
  if not current_index then return false, read_error end
  if current_index ~= entry.after then
    return false, "Arc index changed after staging; refusing to overwrite it"
  end

  local before_lines, before_has_eol = split_text(entry.before)
  local replacement = {}
  for i = entry.hunk[1], entry.hunk[1] + entry.hunk[2] - 1 do
    replacement[#replacement + 1] = before_lines[i]
  end

  local stage_error = stage_content({ arc = entry.arc }, entry.before)
  if stage_error then return false, stage_error end

  local buffer_start = entry.hunk[3] - (entry.hunk[4] > 0 and 1 or 0)
  vim.api.nvim_buf_set_lines(
    bufnr,
    buffer_start,
    buffer_start + entry.hunk[4],
    false,
    replacement
  )
  if hunk_touches_eof(entry.hunk, entry.buffer_line_count) then
    vim.bo[bufnr].endofline = before_has_eol
  end

  table.remove(history)
  refresh()
  notify("Reset staged Arc hunk")
  return true
end

same_hunk = function(left, right)
  for i = 1, 4 do
    if left[i] ~= right[i] then return false end
  end

  return true
end

refresh = function()
  pcall(function() require("gitsigns").refresh() end)
end

notify = function(message, level)
  vim.notify(message, level or vim.log.levels.INFO, { title = "Arc gitsigns" })
end

return M
