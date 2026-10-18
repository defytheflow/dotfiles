local telescope = require("telescope")
local actions = require("telescope.actions")

local arc_repo = require("defytheflow.vcs").is_arc_repo()

local grep_args = { "--glob", "!**/node_modules/**", "--glob", "!**/.git/**" }
if arc_repo then
  vim.list_extend(grep_args, { "--no-require-git", "--glob", "!**/.arc/**" })
end

telescope.setup {
  defaults = {
    layout_strategy = "vertical",
    -- layout_strategy = "flex",

    layout_config = {
      preview_cutoff = 140, -- disables the preview when columns are less than this value

      width = 0.9,
      height = 0.75,

      horizontal = {
        width = { padding = 0.15 },
      },

      vertical = {
        height = 0.65,
        preview_height = 0.75,
        prompt_position = "top",
      },
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close, -- TODO: doesn't work
        ["<C-u>"] = false,         -- clears the prompt, scrolls the previewer by default
        ["<C-t>"] = require("trouble.sources.telescope").open,
      },
      n = {
        ["<C-t>"] = require("trouble.sources.telescope").open,
      }
    },
  },
  pickers = {
    live_grep = { additional_args = grep_args },
    grep_string = { additional_args = grep_args },
    -- Use Git's Delta pager; -Rc preserves colors and paints from the top.
    git_status = {
      previewer = require("telescope.previewers").new_termopen_previewer {
        env = { LESS = "" }, -- Disable Git's default quit-if-one-screen flags.
        get_command = function(entry, status)
          -- Preview new files with Bat instead of a diff.
          if entry.status == "??" or entry.status == "A " then
            return { "bat", "--color=always", "--paging=always", "--pager=less -Rc", "--", entry.path }
          end
          return {
            "git", "-C", status.picker.cwd, "-c", "core.pager=delta",
            "-c", "delta.paging=always", "-c", "delta.pager=less -Rc",
            "diff", "HEAD", "--", entry.value,
          }
        end,
      },
    },
    git_files = {
      show_untracked = true,
    },
    find_files = {
      hidden = true,
      find_command = function(opts)
        local command = { "rg", "--files", "--color", "never", "--glob", "!**/.git/**" }
        if arc_repo then
          -- Ripgrep otherwise skips .gitignore files outside Git repositories.
          vim.list_extend(command, { "--no-require-git", "--glob", "!**/.arc/**" })
        end
        if not opts.no_ignore then
          vim.list_extend(command, { "--glob", "!**/node_modules/**" })
        end
        return command
      end,
      -- no_ignore = true, -- includes files from .gitignore
    },
  },
}

pcall(require("telescope").load_extension, "fzf")
require("telescope").load_extension("emoji")
if arc_repo then
  telescope.load_extension("arc")
end

local function vcs_picker(arc_picker, git_picker, opts)
  return function()
    local picker_opts = opts and vim.deepcopy(opts) or nil

    if arc_repo then
      telescope.extensions.arc[arc_picker](picker_opts)
    else
      require("telescope.builtin")[git_picker](picker_opts)
    end
  end
end

local status_picker = vcs_picker("status", "git_status", {
  -- Arc provides its own preview-command hook.
  preview_cmd = arc_repo and {
    staged = [[arc diff --git --no-color --cached -- "%s" | delta --paging=always --pager='less -Rc']],
    unstaged = [[arc diff --git --no-color -- "%s" | delta --paging=always --pager='less -Rc']],
    untracked = [[bat --color=always --style=plain --paging=always --pager='less -Rc' -- "%s"]],
  } or nil,
  layout_config = {
    preview_cutoff = 0,
    preview_height = 0.65,
    width = 0.95,
    height = 0.95,
  }
})

-- Telescope arc
if arc_repo then
  vim.keymap.set("n", "<leader>as", status_picker, { desc = "[A]rc [S]tatus" })
  vim.keymap.set('n', '<leader>af', "<cmd>Telescope arc ls_files<cr>")
  vim.keymap.set('n', '<leader>ac', "<cmd>Telescope arc commits<cr>")
  vim.keymap.set('n', '<leader>ab', "<cmd>Telescope arc branches<cr>")
  vim.keymap.set('n', '<leader>at', "<cmd>Telescope arc stash<cr>")
  vim.keymap.set('n', '<leader>ap', "<cmd>Telescope arc pr_list<cr>")
end

vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>ff", function()
  require("telescope.builtin").find_files { no_ignore = true }
end, { desc = "[F]ind [F]iles" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", function()
  require("telescope.builtin").live_grep {
    layout_config = {
      preview_cutoff = 0,
      preview_height = 0.6,
      width = 0.95,
      height = 0.95,
    }
  }
end, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sw", function()
  require("telescope.builtin").grep_string {
    layout_config = {
      preview_cutoff = 0,
      preview_height = 0.6,
      width = 0.95,
      height = 0.95,
    }
  }
end, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", require("telescope.builtin").keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>sH", require("telescope.builtin").search_history, { desc = "[S]earch [H]istory" })
vim.keymap.set("n", "<leader>sb", vcs_picker("branches", "git_branches"), { desc = "[S]earch VCS [B]ranches" })
vim.keymap.set("n", "<leader>sc", vcs_picker("commits", "git_commits"), { desc = "[S]earch VCS [C]ommits" })
vim.keymap.set("n", "<leader>ss", status_picker, { desc = "[S]earch VCS [S]tatus" })
vim.keymap.set("n", "<leader>se", "<cmd>Telescope emoji<cr>", { desc = "[S]earch [E]moji" })
vim.keymap.set("n", "<leader>sv", function()
  require("telescope.builtin").find_files { cwd = vim.fn.stdpath("config") }
end, { desc = "[S]earch [V]im" })

vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  require("telescope.builtin").current_buffer_fuzzy_find {
    layout_config = { height = 0.75, width = 0.99 }
  }
end, { desc = "[/] Fuzzily search in current buffer" })
