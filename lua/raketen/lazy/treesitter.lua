return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local config = require("nvim-treesitter.config")

    config.setup({
      ensure_installed = {
        "rust", "svelte", "css", "c", "lua", "vim", "go", "vimdoc", "elixir", "javascript", "html", "python",
        "typescript"
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
      matchup = {
        enable = true,
      },
    })
  end
}
