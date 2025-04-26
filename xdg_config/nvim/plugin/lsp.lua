vim.diagnostic.config {
  severity_sort = true,
  float = {
    border = "rounded",
    source = "always",
  }
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover,
  { border = "rounded" }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  { border = "rounded" }
)

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics in a floating window" })
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

vim.keymap.set("n", "[E", function()
  vim.diagnostic.goto_prev { severity = vim.diagnostic.severity.ERROR }
end, { desc = "Go to previous [E]rror" })

vim.keymap.set("n", "]E", function()
  vim.diagnostic.goto_next { severity = vim.diagnostic.severity.ERROR }
end, { desc = "Go to next [E]rror" })

local on_attach = function(_, bufnr)
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

  vim.keymap.set("n", "<leader>O", ":Lspsaga outline toggle<CR>", { desc = "LSP: [O]utline" })
  vim.keymap.set("n", "<leader>lr", vim.cmd.LspRestart, { desc = "LSP: [R]estart" })

  nmap("<leader>rn", function()
    vim.lsp.buf.rename()
    -- vim.cmd.Lspsaga("rename") -- vim.lsp.buf.rename
  end, "[R]e[n]ame")

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

  nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
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
  nmap("K", vim.lsp.buf.hover, "Hover Documentation")
  nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

  nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
  nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
  nmap("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "[W]orkspace [L]ist Folders")

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, { desc = "Format current buffer with LSP" })

  nmap("<leader>f", vim.lsp.buf.format, "Format")
  xmap("<leader>f", vim.lsp.buf.format, "Format")

  -- Formats code on save
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.go", "*.lua" },
    callback = function()
      vim.lsp.buf.format { async = false }
    end
  })
end

local servers = {
  clangd = {},
  -- gopls = {}, -- mason can't download it and throws an error
  pyright = {},
  rust_analyzer = {},
  ts_ls = {},
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
  eslint = {},
  gopls = {},
  emmet_language_server = {},
  html = { filetypes = { "html", "twig", "hbs" } },
  cssls = {},
  lua_ls = {
    Lua = {
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

local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require("lspconfig")[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}

require("lspconfig").jsonls.setup({
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

require("lspconfig").ts_ls.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    require("twoslash-queries").attach(client, bufnr)
  end
}

-- NOTE: mason can't install it
require("lspconfig").sourcekit.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

-- NOTE: mason throws an error trying to install it
require("lspconfig").ocamllsp.setup {
  capabilities = capabilities,
  on_attach = on_attach,
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
    enable = false,
  },
  lightbulb = {
    virtual_text = false,
  },
  outline = {
    -- auto_preview = false,
  },
  definition = {
    width = 1.0,
  }
}

local null_ls = require("null-ls")

null_ls.setup {
  debug = true,
  sources = {
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.sql_formatter.with {
      filetypes = { "sql", "mysql", }
    },
    null_ls.builtins.formatting.prettier.with {
      -- extra_args = { "--print-width", "90" }
    },
    null_ls.builtins.diagnostics.phpstan.with {
      args = { "analyze", "--error-format", "json", "--no-progress" }
    }
  },
  on_attach = function(_, bufnr)
    local desc = "Format current buffer with null-ls"

    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
      vim.lsp.buf.format()
    end, { desc = desc })

    vim.keymap.set({ "n", "x" }, "<leader>f", vim.lsp.buf.format, { buffer = bufnr, desc = desc })
  end
}
