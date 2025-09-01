return {
  -- LSP Configuration
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

      -- 2) mason-lspconfig: install + auto-enable servers
      require("mason-lspconfig").setup({
        ensure_installed = {
          "gopls",
          "ts_ls", -- was tsserver; ts_ls is correct for v2
          "svelte",
          "pyright",
          "cssls",
          "lua_ls",              -- recommended for Neovim config/dev
        },
        automatic_enable = true, --  replaces setup_handlers()
        -- optional: automatic_installation = true,
      })

      -- 3) Your on_attach (keymaps etc.)
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

      -- 4) Advertise completion capabilities to all servers
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- 5) Global LSP defaults (picked up automatically for every server)
      vim.lsp.config('*', {
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },

  -- (You can keep these; they're redundant because of the dependencies above.)
  { "williamboman/mason.nvim",          build = ":MasonUpdate" },
  { "williamboman/mason-lspconfig.nvim" },

  -- conform.nvim (unchanged)
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local conform = require("conform")
      conform.setup({
        formatters_by_ft = {
          go = { "gofmt" },
          lua = { "stylua" },
          javascript = { "prettierd", "prettier", stop_after_first = true },
        },
      })
      vim.keymap.set({ "n", "v" }, "<leader>l", function()
        conform.format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
      end, { desc = "Format file or range (in visual mode)" })
    end,
  },

  -- cmp pieces
  { "hrsh7th/cmp-nvim-lsp" },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        sources = { { name = "nvim_lsp" } },
        snippet = {
          expand = function(args)
            -- requires Neovim 0.10+ (you're on 0.11)
            vim.snippet.expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
      })
    end,
  },
}
