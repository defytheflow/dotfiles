local telescope = require("telescope")
local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

telescope.setup {
  defaults = {
    -- layout_strategy = "vertical",
    layout_config = {
      preview_cutoff = 140, -- disables the preview when columns are less than this value
    },
    file_ignore_patterns = { ".git/*" },
    mappings = {
      i = {
        ["<esc>"] = actions.close, -- TODO: doesn't work
        ["<C-u>"] = false,         -- clears the prompt, scrolls the previewer by default
        ["<C-t>"] = trouble.open_with_trouble,
      },
      n = {
        ["<C-t>"] = trouble.open_with_trouble,
      }
    },
  },
  pickers = {
    git_files = {
      show_untracked = true,
    },
    find_files = {
      hidden = true,
      no_ignore = true, -- includes files from .gitignore
    },
  },
}

pcall(require("telescope").load_extension, "fzf")
require("telescope").load_extension("emoji")

vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })

vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[F]ind [F]iles" })
vim.keymap.set("n", "<leader>fw", require("telescope.builtin").grep_string, { desc = "[F]ind current [W]ord" })
vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>fr", require("telescope.builtin").resume, { desc = "[F]ind [R]esume" })
vim.keymap.set("n", "<leader>fe", "<cmd>Telescope emoji<cr>", { desc = "[F]ind [E]moji" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").git_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", require("telescope.builtin").keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>sH", require("telescope.builtin").search_history, { desc = "[S]earch [H]istory" })
vim.keymap.set("n", "<leader>sb", require("telescope.builtin").git_branches, { desc = "[S]earch Git [B]ranches" })
vim.keymap.set("n", "<leader>sc", require("telescope.builtin").git_commits, { desc = "[S]earch Git [C]ommits" })
vim.keymap.set("n", "<leader>ss", require("telescope.builtin").git_status, { desc = "[Search] Git [S]tatus" })
vim.keymap.set("n", "<leader>se", "<cmd>Telescope emoji<cr>", { desc = "[S]earch [E]moji" })

vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", require("telescope.builtin").current_buffer_fuzzy_find, { desc = "[/] Fuzzily search in current buffer" })
