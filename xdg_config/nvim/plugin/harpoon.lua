local harpoon = require("harpoon")

-- Show file-type icons without inserting them into Harpoon's editable paths.
local function add_popup_icons(bufnr)
  local ns = vim.api.nvim_create_namespace("harpoon_file_icons")
  local function update_icons()
    vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
    for i, path in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)) do
      if path:match("%S") then
        local icon, highlight = require("nvim-web-devicons").get_icon(vim.fn.fnamemodify(path, ":t"), nil, { default = true })
        vim.api.nvim_buf_set_extmark(bufnr, ns, i - 1, 0, {
          virt_text = { { icon .. " ", highlight } },
          virt_text_pos = "inline",
        })
      end
    end
  end
  update_icons()
  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    buffer = bufnr,
    callback = update_icons,
  })
end

harpoon:setup {
  settings = {
    save_on_toggle = true,
    sync_on_ui_close = true,
  },
}

harpoon:extend(require("harpoon.extensions").builtins.highlight_current_file())

harpoon:extend {
  UI_CREATE = function(context)
    add_popup_icons(context.bufnr)

    vim.keymap.set("n", "<C-v>", function()
      harpoon.ui:select_menu_item { vsplit = true }
    end, { buffer = context.bufnr, desc = "Open in vertical split" })

    vim.keymap.set("n", "<C-x>", function()
      harpoon.ui:select_menu_item { split = true }
    end, { buffer = context.bufnr, desc = "Open in horizontal split" })
  end,
}

vim.keymap.set("n", "<leader>ma", function()
  harpoon:list():add()
end, { desc = "[M]ark [A]dd" })

vim.keymap.set("n", "<leader>ml", function()
  harpoon.ui:toggle_quick_menu(harpoon:list(), {
    ui_width_ratio = 1,
    ui_max_width = math.min(100, vim.o.columns - 4),
    ui_fallback_width = math.min(100, vim.o.columns - 4),
    height_in_lines = math.min(15, vim.o.lines - 4),
    border = "rounded",
  })
end, { desc = "[M]ark [L]ist" })

vim.keymap.set("n", "<leader>mf", function()
  local files = {}
  local list = harpoon:list()
  for i = 1, list:length() do
    local item = list:get(i)
    if item then table.insert(files, item.value) end
  end

  local conf = require("telescope.config").values
  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table {
      results = files,
      entry_maker = require("telescope.make_entry").gen_from_file { disable_devicons = false },
    },
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end, { desc = "[M]arks [F]ind" })

for i = 1, 5 do
  vim.keymap.set("n", "<leader>m" .. i, function()
    harpoon:list():select(i)
  end, { desc = "Go to [M]ark " .. i })
end
