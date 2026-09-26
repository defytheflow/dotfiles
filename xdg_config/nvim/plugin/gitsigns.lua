local function is_arc_repo()
  if vim.fn.executable("arc") ~= 1 then return false end

  vim.fn.system({ "arc", "root" })
  return vim.v.shell_error == 0
end

local arc_repo = is_arc_repo()

require("gitsigns").setup {
  base = arc_repo and "trunk" or nil,
  current_line_blame = true,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.next_hunk() end)
      return "<Ignore>"
    end, { expr = true, desc = "Next hunk" })

    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, { expr = true, desc = "Previous hunk" })

    if not arc_repo then
      map("n", "]s", function()
        if vim.wo.diff then return "]s" end
        vim.schedule(function() gs.next_hunk({ target = "staged" }) end)
        return "<Ignore>"
      end, { expr = true, desc = "Next staged hunk" })

      map("n", "[s", function()
        if vim.wo.diff then return "[s" end
        vim.schedule(function() gs.prev_hunk({ target = "staged" }) end)
        return "<Ignore>"
      end, { expr = true, desc = "Previous staged hunk" })
    end

    -- Actions
    if arc_repo then
      local arc_gitsigns = require("defytheflow.arc_gitsigns")

      map("n", "<leader>hs", arc_gitsigns.stage_hunk, { desc = "[H]unk [s]tage" })
      map("v", "<leader>hs", function()
        arc_gitsigns.stage_hunk { vim.fn.line("."), vim.fn.line("v") }
      end)
      map("n", "<leader>hr", arc_gitsigns.reset_hunk, { desc = "[H]unk [r]eset" })
      map("v", "<leader>hr", function()
        arc_gitsigns.reset_hunk { vim.fn.line("."), vim.fn.line("v") }
      end, { desc = "[H]unk [r]eset" })
      map("n", "<leader>hS", arc_gitsigns.stage_buffer, { desc = "[H]unk [S]tage buffer" })
      map("n", "<leader>hu", arc_gitsigns.unstage_hunk, { desc = "[H]unk [U]nstage" })
      map("v", "<leader>hu", function()
        arc_gitsigns.unstage_hunk { vim.fn.line("."), vim.fn.line("v") }
      end, { desc = "[H]unk [U]nstage" })
      map("n", "<leader>hR", arc_gitsigns.reset_buffer, { desc = "[H]unk [R]eset buffer" })
      map("n", "<leader>hU", arc_gitsigns.unstage_buffer, { desc = "[H]unk [U]nstage buffer" })
    else
      map("n", "<leader>hs", gs.stage_hunk, { desc = "[H]unk [s]tage" })
      map("n", "<leader>hr", gs.reset_hunk, { desc = "[H]unk [r]eset" })
      map("v", "<leader>hs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end)
      map("v", "<leader>hr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end)
      map("n", "<leader>hS", gs.stage_buffer, { desc = "[H]unk [S]tage buffer" })
      map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "[H]unk [U]nstage" })
      map("n", "<leader>hR", gs.reset_buffer, { desc = "[H]unk [R]eset buffer" })
    end

    map("n", "<leader>hp", gs.preview_hunk, { desc = "[H]unk [P]review" })
    map("n", "<leader>hb", function() gs.blame_line { full = true } end, { desc = "[H]unk [B]lame" })
    map("n", "<leader>tb", gs.toggle_current_line_blame, { desc = "Hunk [T]oggle [B]lame" })
    map("n", "<leader>hd", gs.diffthis, { desc = "[H]unk [D]iff" })
    map("n", "<leader>hD", function() gs.diffthis("~") end)
    map("n", "<leader>hh", gs.toggle_linehl, { desc = "[H]unk [H]ighlight toggle" })
    map("n", "<leader>td", gs.toggle_deleted, { desc = "Hunk [T]oggle [D]eleted" })

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end
}

-- Highlights
vim.cmd("highlight GitSignsAdd guifg=#C5E478")
vim.cmd("highlight GitSignsChange guifg=#C792EA")
