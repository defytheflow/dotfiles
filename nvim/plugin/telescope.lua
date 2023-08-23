local telescope = require("telescope")

telescope.setup({
  defaults = {
    layout_config = {
      preview_cutoff = 140, -- disables the preview when columns are less than this value
    },
    file_ignore_patterns = { ".git/*" },
    mappings = {
      i = {
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
})

telescope.load_extension("emoji")
telescope.load_extension("coc")

local builtin = require("telescope.builtin")
local extensions = telescope.extensions

vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [b]uffers" })
vim.keymap.set("n", "<leader>fB", builtin.git_branches, { desc = "[F]ind [B]ranches" })
vim.keymap.set("n", "<leader>fc", builtin.git_commits, { desc = "[F]ind [C]ommits" })
vim.keymap.set("n", "<leader>fd", extensions.coc.diagnostics, { desc = "[F]ind [D]iagnostics" })
vim.keymap.set("n", "<leader>fe", extensions.emoji.emoji, { desc = "[F]ind [E]moji" })
vim.keymap.set("n", "<leader>ff", builtin.git_files, { desc = "[F]ind [f]iles (git)" })
vim.keymap.set("n", "<leader>fF", builtin.find_files, { desc = "[F]ind [F]iles (all)" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind [g]rep live" })
vim.keymap.set("n", "<leader>fG", builtin.grep_string, { desc = "[F]ind [G]rep under cursor" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp" })
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "[F]ind [O]ld files" })
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope coc document_symbols<cr>", { desc = "[F]ind [s]ymbols (document)" })
vim.keymap.set("n", "<leader>fS", "<cmd>Telescope coc workspace_symbols<cr>", { desc = "[F]ind [S]ymbols (workspace)" })
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "[F]ind [T]odos" })
vim.keymap.set("n", "<leader>f/", builtin.search_history)

-- These throw lua errors
-- vim.keymap.set("n", "<leader>fs", extensions.coc.document_symbols, {})
-- vim.keymap.set("n", "<leader>fS", extensions.coc.workspace_symbols, {})
