return {
  -- Telescope und seine Abh�ngigkeiten
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup{
        defaults = {
          -- Standardkonfiguration f�r Telescope
          mappings = {
            i = {
              ["<C-h>"] = "which_key"
            }
          }
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
            hidden = true,
          },
        },
      }
    end,
  },
  -- Telescope File Browser Erweiterung
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      -- Laden der File Browser Erweiterung
      require('telescope').load_extension('file_browser')
      -- Tastenkombination f�r den File Browser
      vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>Telescope file_browser<cr>', { noremap = true, silent = true })
    end,
  },
}
