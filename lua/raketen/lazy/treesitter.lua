return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- New nvim-treesitter (1.0+) uses Neovim's built-in treesitter API
    -- The old `require("nvim-treesitter.configs").setup()` no longer exists

    -- Add the runtime subdirectory to runtimepath for queries
    local ts_path = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter"
    vim.opt.rtp:prepend(ts_path .. "/runtime")

    -- Enable treesitter highlighting and indent for all buffers
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        -- Skip special buffers
        if vim.bo[args.buf].buftype ~= "" then
          return
        end
        -- Try to start treesitter highlighting for this buffer
        pcall(vim.treesitter.start, args.buf)
      end,
    })
  end,
}
