return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    -- Runtime-Pfad für Queries hinzufügen (nvim-treesitter v1.0+)
    local ts_path = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter"
    vim.opt.runtimepath:append(ts_path .. "/runtime")

    local ts = require("nvim-treesitter")

    -- 1. Parser installieren (async)
    ts.install({
      "python", "svelte", "typescript", "javascript", "html", "css", "lua", "rust", "zig",
    })

    -- 2. Highlighting beim Öffnen von Dateien aktivieren
    local langs = { "python", "svelte", "typescript", "javascript", "html", "css", "lua", "rust", "zig" }
    vim.api.nvim_create_autocmd("FileType", {
      pattern = langs,
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
