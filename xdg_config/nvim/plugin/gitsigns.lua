require("gitsigns").setup {
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
    end, { expr = true, desc = "Next unstaged hunk" })

    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.prev_hunk() end)
      return "<Ignore>"
    end, { expr = true, desc = "Previous unstaged hunk" })

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

    -- Actions
    map("n", "<leader>hs", gs.stage_hunk, { desc = "[H]unk [s]tage" })
    map("n", "<leader>hr", gs.reset_hunk, { desc = "[H]unk [r]eset" })
    map("v", "<leader>hs", function() gs.stage_hunk { vim.fn.line("."), vim.fn.line("v") } end)
    map("v", "<leader>hr", function() gs.reset_hunk { vim.fn.line("."), vim.fn.line("v") } end)
    map("n", "<leader>hS", gs.stage_buffer, { desc = "[H]unk [S]tage buffer" })
    map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "[H]unk [U]nstage" })
    map("n", "<leader>hR", gs.reset_buffer, { desc = "[H]unk [R]eset buffer" })
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
