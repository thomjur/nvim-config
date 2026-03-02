return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    local ts = require("nvim-treesitter")

    -- 1. Parser installieren
    ts.install({
      "python", "svelte", "typescript", "javascript", "html", "css", "lua", "rust", "zig"
    })

    -- 2. Highlighting manuell aktivieren (WICHTIG!)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python", "svelte", "typescript", "javascript", "html", "css", "lua", "rust", "zig" },
      callback = function()
        vim.treesitter.start()
      end,
    })
  end
}
