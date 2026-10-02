local languages = {
  "bash",
  "c",
  "css",
  "html",
  "javascript",
  "jsdoc",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "php",
  "phpdoc",
  "python",
  "sql",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
}

require("nvim-treesitter").install(languages)

vim.api.nvim_create_autocmd("FileType", {
  callback = function(event)
    if pcall(vim.treesitter.start, event.buf) then
      vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

require("nvim-ts-autotag").setup {
  opts = {
    enable_close_on_slash = false,
  },
}

require("nvim-treesitter-textobjects").setup {
  select = {
    lookahead = true,
  },
  move = {
    set_jumps = true,
  },
}

vim.keymap.set({ "n", "x" }, "<c-space>", function()
  vim.treesitter.select("parent")
end, { desc = "Select parent syntax node" })
vim.keymap.set("x", "<c-s>", function()
  vim.treesitter.select("parent")
end, { desc = "Select parent syntax node" })
vim.keymap.set("x", "<M-space>", function()
  vim.treesitter.select("child")
end, { desc = "Select child syntax node" })

local select = require("nvim-treesitter-textobjects.select")
local selections = {
  aa = { "@parameter.outer", "textobjects" },
  ia = { "@parameter.inner", "textobjects" },
  af = { "@function.outer", "textobjects" },
  ["if"] = { "@function.inner", "textobjects" },
  ac = { "@class.outer", "textobjects" },
  ic = { "@class.inner", "textobjects" },
  as = { "@local.scope", "locals" },
  aC = { "@conditional.outer", "textobjects" },
  iC = { "@conditional.inner", "textobjects" },
  al = { "@loop.outer", "textobjects" },
  il = { "@loop.inner", "textobjects" },
}
for mapping, query in pairs(selections) do
  local capture, query_group = query[1], query[2]
  vim.keymap.set({ "x", "o" }, mapping, function()
    select.select_textobject(capture, query_group)
  end)
end

local move = require("nvim-treesitter-textobjects.move")
local movements = {
  ["]m"] = { move.goto_next_start, "@function.outer", "textobjects" },
  ["]f"] = { move.goto_next_start, "@function.outer", "textobjects" },
  ["]]"] = { move.goto_next_start, "@class.outer", "textobjects" },
  ["]l"] = { move.goto_next_start, "@loop.outer", "textobjects" },
  ["]s"] = { move.goto_next_start, "@local.scope", "locals" },
  ["]z"] = { move.goto_next_start, "@fold", "folds" },
  ["]C"] = { move.goto_next_start, "@conditional.outer", "textobjects" },
  ["]M"] = { move.goto_next_end, "@function.outer", "textobjects" },
  ["]["] = { move.goto_next_end, "@class.outer", "textobjects" },
  ["[m"] = { move.goto_previous_start, "@function.outer", "textobjects" },
  ["[f"] = { move.goto_previous_start, "@function.outer", "textobjects" },
  ["[["] = { move.goto_previous_start, "@class.outer", "textobjects" },
  ["[l"] = { move.goto_previous_start, "@loop.outer", "textobjects" },
  ["[s"] = { move.goto_previous_start, "@local.scope", "locals" },
  ["[z"] = { move.goto_previous_start, "@fold", "folds" },
  ["[C"] = { move.goto_previous_start, "@conditional.outer", "textobjects" },
  ["[M"] = { move.goto_previous_end, "@function.outer", "textobjects" },
  ["[]"] = { move.goto_previous_end, "@class.outer", "textobjects" },
}
for mapping, movement in pairs(movements) do
  local jump, capture, query_group = movement[1], movement[2], movement[3]
  vim.keymap.set({ "n", "x", "o" }, mapping, function()
    jump(capture, query_group)
  end)
end

local swap = require("nvim-treesitter-textobjects.swap")
vim.keymap.set("n", "]A", function()
  swap.swap_next("@parameter.inner")
end)
vim.keymap.set("n", "]F", function()
  swap.swap_next("@function.outer")
end)
vim.keymap.set("n", "[A", function()
  swap.swap_previous("@parameter.inner")
end)
vim.keymap.set("n", "[F", function()
  swap.swap_previous("@function.outer")
end)

vim.keymap.set("n", "<leader>ct", function()
  vim.cmd.TSContextToggle()
end, { desc = "[C]ontext [T]oggle" })

vim.keymap.set("n", "<leader>cg", function()
  require("treesitter-context").go_to_context()
end, { desc = "[C]ontext [G]o" })

vim.g.skip_ts_context_commentstring_module = true
