local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup {
  defaults = {
    layout_config = {
      -- preview_cutoff = 140, -- disables the preview when columns are less than this value
    },
    file_ignore_patterns = { ".git/*" },
    mappings = {
      i = {
        ["<esc>"] = actions.close, -- TODO: doesn't work
        ["<C-u>"] = false, -- clears the prompt, scrolls the previewer by default
      },
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

telescope.load_extension("emoji")

local builtin = require("telescope.builtin")
local extensions = telescope.extensions

vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [b]uffers" })
vim.keymap.set("n", "<leader>fB", builtin.git_branches, { desc = "[F]ind [B]ranches" })
vim.keymap.set("n", "<leader>fc", builtin.git_commits, { desc = "[F]ind [C]ommits" })
vim.keymap.set("n", "<leader>fe", extensions.emoji.emoji, { desc = "[F]ind [E]moji" })
vim.keymap.set("n", "<leader>ff", builtin.git_files, { desc = "[F]ind [f]iles (git)" })
vim.keymap.set("n", "<leader>fF", builtin.find_files, { desc = "[F]ind [F]iles (all)" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind [g]rep live" })
vim.keymap.set("n", "<leader>fG", builtin.grep_string, { desc = "[F]ind [G]rep under cursor" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[F]ind [K]eymaps" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "[F]ind [O]ld files" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[F]ind [R]esume" })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "[F]ind [T]odos" })
vim.keymap.set("n", "<leader>f/", builtin.search_history)
vim.keymap.set("n", "<leader>fl", builtin.git_status)

vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
  builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>se", extensions.emoji.emoji, { desc = "[S]earch [E]moji" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
