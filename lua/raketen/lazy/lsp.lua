return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- 1) mason core
      require("mason").setup()

      -- 2) mason-lspconfig: install + auto-enable servers (v2 API)
      require("mason-lspconfig").setup({
        ensure_installed = {
          "gopls",
          "ts_ls", -- new id
          "svelte",
          "pyright",
          "cssls",
          "clangd",
          "lua_ls",
          "rust_analyzer",
        },
        automatic_enable = true, -- <— v2 feature
      })

      -- 3) on_attach + capabilities
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_deep_extend("force", opts, { desc = "LSP References" }))
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_deep_extend("force", opts, { desc = "LSP Definition" }))
        vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_deep_extend("force", opts, { desc = "LSP Hover" }))
        vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol,
          vim.tbl_deep_extend("force", opts, { desc = "Workspace Symbols" }))
        vim.keymap.set("n", "<leader>vd", vim.diagnostic.setloclist,
          vim.tbl_deep_extend("force", opts, { desc = "Diagnostics -> loclist" }))
        vim.keymap.set("n", "[d", vim.diagnostic.goto_next,
          vim.tbl_deep_extend("force", opts, { desc = "Next Diagnostic" }))
        vim.keymap.set("n", "]d", vim.diagnostic.goto_prev,
          vim.tbl_deep_extend("force", opts, { desc = "Prev Diagnostic" }))
        vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action,
          vim.tbl_deep_extend("force", opts, { desc = "Code Action" }))
        vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, vim.tbl_deep_extend("force", opts, { desc = "Rename" }))
        vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help,
          vim.tbl_deep_extend("force", opts, { desc = "Signature Help" }))
      end
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 4) Global defaults for ALL servers (Neovim 0.11+)
      vim.lsp.config("*", {
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },

  { "williamboman/mason.nvim",          build = ":MasonUpdate" },
  { "williamboman/mason-lspconfig.nvim" },

  -- conform.nvim (C/C++ formatting)
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          go         = { "gofmt" },
          lua        = { "stylua" },
          javascript = { "prettierd", "prettier" },
          c          = { "clang-format" },
          cpp        = { "clang-format" },
        },
      })
      vim.keymap.set({ "n", "v" }, "<leader>l", function()
        conform.format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },

  { "hrsh7th/cmp-nvim-lsp" },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        completion = {
          autocomplete = {
            cmp.TriggerEvent.TextChanged,
            cmp.TriggerEvent.InsertEnter,
          },
          keyword_length = 1, -- Vorschläge ab dem ersten getippten Zeichen
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
          ["<Up>"] = cmp.mapping.select_next_item(),
          ["<Down>"] = cmp.mapping.select_prev_item(),
        }),
      })
    end,
  },
}
