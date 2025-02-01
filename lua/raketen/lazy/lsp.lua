return { 
  {'neovim/nvim-lspconfig',
  config= function()
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Reference" }))
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Goto Definition" }))
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Hover" }))
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Workspace Symbol" }))
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.setloclist() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Show Diagnostics" }))
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, vim.tbl_deep_extend("force", opts, { desc = "Next Diagnostic" }))
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, vim.tbl_deep_extend("force", opts, { desc = "Previous Diagnostic" }))
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Code Action" }))
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, vim.tbl_deep_extend("force", opts, { desc = "LSP References" }))
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Rename" }))
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, vim.tbl_deep_extend("force", opts, { desc = "LSP Signature Help" }))
    end
    require'lspconfig'.gopls.setup{
      on_attach = on_attach
    }
    require'lspconfig'.ts_ls.setup{
      on_attach = on_attach
    }
    require'lspconfig'.svelte.setup {
      on_attach = on_attach
    }
    require'lspconfig'.pyright.setup{
      on_attach = on_attach
    }
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    require'lspconfig'.cssls.setup{
      on_attach = on_attach,
      capabilities = capabilities,
      }
    local lspconfig_defaults = require('lspconfig').util.default_config
    lspconfig_defaults.capabilities = vim.tbl_deep_extend('force', lspconfig_defaults.capabilities, require('cmp_nvim_lsp').default_capabilities())
  end
  },
  { "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        go = {  "gofmt"  },
        lua = { "stylua" },
        javascript = { "prettierd", "prettier", stop_after_first=true},
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>l", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
  },
  {'hrsh7th/cmp-nvim-lsp'},
  {'hrsh7th/nvim-cmp',
  config = function()
      local cmp = require('cmp')

      cmp.setup({
        sources = {
          {name = 'nvim_lsp'},
        },
        snippet = {
          expand = function(args)
            -- You need Neovim v0.10 to use vim.snippet
            vim.snippet.expand(args.body)
          end,
        },
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true })
      }),
      })  
  end
  },
}
