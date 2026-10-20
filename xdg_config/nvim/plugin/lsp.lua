vim.diagnostic.config {
  severity_sort = true,
  virtual_text = true,
  float = {
    border = "rounded",
    source = "always",
  }
}

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump { count = -1, float = true }
end, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump { count = 1, float = true }
end, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics in a floating window" })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.keymap.set("n", "[E", function()
  vim.diagnostic.jump { count = -1, float = true, severity = vim.diagnostic.severity.ERROR }
end, { desc = "Go to previous [E]rror" })

vim.keymap.set("n", "]E", function()
  vim.diagnostic.jump { count = 1, float = true, severity = vim.diagnostic.severity.ERROR }
end, { desc = "Go to next [E]rror" })

local function format_buffer()
  -- gopls organizes imports through a separate code action; apply its edits before formatting.
  if vim.bo.filetype == "go" then
    for _, client in ipairs(vim.lsp.get_clients { bufnr = 0, name = "gopls" }) do
      local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
      params.context = { diagnostics = {}, only = { "source.organizeImports" } }
      local response, err = client:request_sync("textDocument/codeAction", params, 3000, 0)
      if not response or response.err then
        vim.notify("Could not organize Go imports: " .. vim.inspect(err or (response and response.err)), vim.log.levels.WARN)
        return
      end
      for _, action in ipairs(response.result or {}) do
        if action.edit then
          vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
        end
      end
    end
  end
  vim.lsp.buf.format()
end

-- Jump to the implementation in TypeScript/JavaScript, with normal LSP definitions as a fallback.
-- This makes gd open React component code instead of an import or React's FC declaration.
local function goto_definition()
  local client = vim.lsp.get_clients { bufnr = 0, name = "ts_ls" }[1]
  if not client then
    vim.lsp.buf.definition()
    return
  end

  -- TypeScript's source lookup follows React component imports instead of stopping at FC types.
  local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
  client:exec_cmd({
    command = "_typescript.goToSourceDefinition",
    arguments = { params.textDocument.uri, params.position },
  }, { bufnr = vim.api.nvim_get_current_buf() }, function(err, locations)
    if not err and locations and #locations == 1 then
      vim.lsp.util.show_document(locations[1], client.offset_encoding, { focus = true })
    else
      vim.lsp.buf.definition()
    end
  end)
end

local on_attach = function(client, bufnr)
  if client:supports_method("textDocument/inlayHint") then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
  end

  local map = function(mode)
    return function(keys, func, desc)
      if desc then
        desc = "LSP: " .. desc
      end
      vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
    end
  end

  local nmap = map("n")
  local xmap = map("x")

  if client:supports_method("textDocument/documentHighlight") then
    local function set_reference_highlights(enabled)
      local group = vim.api.nvim_create_augroup("lsp_reference_highlights_" .. bufnr, { clear = true })
      vim.b[bufnr].reference_highlights = enabled
      if enabled then
        vim.api.nvim_create_autocmd("CursorHold", {
          group = group,
          buffer = bufnr,
          callback = vim.lsp.buf.document_highlight,
        })
        vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
          group = group,
          buffer = bufnr,
          callback = vim.lsp.buf.clear_references,
        })
      end
    end

    if vim.b[bufnr].reference_highlights == nil then
      set_reference_highlights(true)
    end

    nmap("<leader>lH", function()
      local enabled = not vim.b[bufnr].reference_highlights
      set_reference_highlights(enabled)
      vim.lsp.buf.clear_references()
      if enabled then vim.lsp.buf.document_highlight() end
      vim.notify("Reference highlights: " .. (enabled and "enabled" or "disabled"))
    end, "Toggle [L]SP reference [H]ighlights")
  end

  nmap("<leader>li", function()
    local enabled = not vim.diagnostic.config().virtual_text
    vim.diagnostic.config { virtual_text = enabled }
    vim.notify("Inline diagnostics: " .. (enabled and "enabled" or "disabled"))
  end, "Toggle [L]SP [I]nline diagnostics")

  if client:supports_method("textDocument/inlayHint") then
    nmap("<leader>lh", function()
      local enabled = not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr }
      vim.lsp.inlay_hint.enable(enabled, { bufnr = bufnr })
      vim.notify("Inlay hints: " .. (enabled and "enabled" or "disabled"))
    end, "Toggle [L]SP inlay [H]ints")
  end

  vim.keymap.set("n", "<leader>O", ":Lspsaga outline toggle<CR>", { desc = "LSP: [O]utline" })
  vim.keymap.set("n", "<leader>lr", function()
    vim.cmd("lsp restart")
  end, { desc = "[L]SP: [R]estart" })

  nmap("<leader>rn", function()
    -- vim.lsp.buf.rename()
    vim.cmd.Lspsaga("rename") -- vim.lsp.buf.rename
  end, "[R]e[n]ame")

  nmap("<leader>pd", function()
    vim.cmd.Lspsaga("peek_definition")
  end, "[P]eek [D]efinition")

  nmap("<leader>pr", function()
    vim.cmd.Lspsaga("finder")
  end, "[P]eek [R]eferences")

  vim.keymap.set("n", "<leader>rN", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
  end, { expr = true, buffer = bufnr, desc = "LSP: [R]e[n]ame" })

  nmap("<leader>ca", function()
    vim.cmd.Lspsaga("code_action") -- vim.lsp.buf.code_action
  end, "[C]ode [A]ction")

  xmap("<leader>ca", function()
    vim.cmd.Lspsaga("code_action") -- vim.lsp.buf.code_action
  end, "[C]ode [A]ction")

  nmap("<leader>k", function()
    vim.cmd.Lspsaga("peek_definition")
  end, "Peek Definition")

  nmap("gd", goto_definition, "[G]oto [D]efinition")
  nmap("gD", function()
    vim.cmd.vsplit()
    vim.lsp.buf.definition()
  end, "[G]oto [D]efinition in vertical split")

  nmap("gr", function()
    require("telescope.builtin").lsp_references {
      fname_width = 50,
      layout_config = {
        preview_cutoff = 0,
        preview_height = 0.6,
        width = 0.95,
        height = 0.95,
      },
    }
  end, "[G]oto [R]eferences")
  nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
  nmap("<leader>ci", function()
    require("trouble").open("lsp_incoming_calls")
  end, "[C]alls [I]ncoming")
  nmap("<leader>co", function()
    require("trouble").open("lsp_outgoing_calls")
  end, "[C]alls [O]utgoing")
  nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
  nmap("<leader>ds", function()
    require("telescope.builtin").lsp_document_symbols {
      fname_width = 50,
      symbol_width = 40,
    }
  end, "[D]ocument [S]ymbols")
  nmap("<leader>ws", function()
    require("telescope.builtin").lsp_dynamic_workspace_symbols {
      fname_width = 50,
      symbol_width = 40,
    }
  end, "[W]orkspace [S]ymbols")
  nmap("K", function()
    vim.lsp.buf.hover { border = "rounded" }
  end, "Hover Documentation")
  nmap("<C-k>", function()
    vim.lsp.buf.signature_help { border = "rounded" }
  end, "Signature Documentation")

  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })

  nmap("<leader>f", format_buffer, "Format")
  xmap("<leader>f", vim.lsp.buf.format, "Format")

  -- Formats code on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go" },
    callback = function()
      vim.lsp.buf.format { async = false }
    end
  })
end

local servers = {
  clangd = {},
  pyright = {},
  rust_analyzer = {},
  ts_ls = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayVariableTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayVariableTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
      },
    },
  },
  tailwindcss = {
    tailwindCSS = {
      experimental = {
        classRegex = {
          { "cva\\(((?:[^()]|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
          { "cx\\(((?:[^()]|\\([^()]*\\))*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" }
        },
      },
    },
  },
  ruff = {},
  eslint = {},
  -- Show inferred types and parameter names to make Go code easier to follow.
  gopls = {
    gopls = {
      hints = {
        assignVariableTypes = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
    },
  },
  emmet_language_server = {},
  html = { filetypes = { "html", "twig", "hbs" } },
  cssls = {},
  lua_ls = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
  intelephense = {},
  phpactor = {},
  sqlls = {},
  jsonls = {},
}

require("neodev").setup()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for server_name, settings in pairs(servers) do
  vim.lsp.config(server_name, {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = settings,
    filetypes = settings.filetypes,
  })
end

vim.lsp.config("jsonls", {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
  settings = {
    json = {
      schemas = {
        {
          fileMatch = { "tsconfig.json" },
          url = "http://json.schemastore.org/tsconfig"
        }
      }
    }
  }
})

vim.lsp.config("ts_ls", {
  capabilities = capabilities,
  -- Keep hints visible without clickable links: TypeScript 5.3.3 crashes on destructured parameter types.
  init_options = { preferences = { interactiveInlayHints = false } },
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    require("twoslash-queries").attach(client, bufnr)
  end
})

-- NOTE: mason can't install it
vim.lsp.config("sourcekit", {
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.lsp.enable("sourcekit")

-- NOTE: mason throws an error trying to install it
vim.lsp.config("ocamllsp", {
  capabilities = capabilities,
  on_attach = on_attach,
})
vim.lsp.enable("ocamllsp")

require("mason-lspconfig").setup {
  ensure_installed = vim.tbl_keys(servers),
}

local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load {
  paths = { os.getenv("DOTFILES_HOME") .. "/vscode/snippets" }
}

luasnip.config.setup {}

---@diagnostic disable-next-line: missing-fields
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<A-i>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    --[[
      Priority is set so that snippets appear above other options.
      Useful for "console.log" to appear above `import log from "node:console"`.
    ]] --
    -- { name = "luasnip", priority = 10 }, -- because of this when you press <c-space> snippets appear first and you need to scroll to see the properties and options, fuck
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
    { name = "emoji" },
  }
}

require("lspsaga").setup {
  symbol_in_winbar = {
    enable = true,
    show_file = true,
    folder_level = 5,
  },
  lightbulb = {
    virtual_text = false,
  },
  outline = {
    auto_preview = false, -- don't display symbol preview in the outline window
  },
  definition = {
    width = 0.75,
  },
}

vim.keymap.set("n", "<leader>lb", "<Cmd>Lspsaga winbar_toggle<CR>", { desc = "Toggle [L]SP [B]readcrumbs" })

local null_ls = require("null-ls")

null_ls.setup {
  debug = false,
  sources = {
    require("none-ls.diagnostics.flake8"),
    null_ls.builtins.formatting.isort,
    null_ls.builtins.diagnostics.mypy,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.sql_formatter.with {
      filetypes = { "sql", "mysql", }
    },
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.diagnostics.phpstan.with {
      args = { "analyze", "--error-format", "json", "--no-progress" }
    }
  },
  on_attach = function(_, bufnr)
    local desc = "Format current buffer with none-ls"

    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
      vim.lsp.buf.format()
    end, { desc = desc })

    vim.keymap.set("n", "<leader>f", format_buffer, { buffer = bufnr, desc = desc })
    vim.keymap.set("x", "<leader>f", vim.lsp.buf.format, { buffer = bufnr, desc = desc })
  end
}
