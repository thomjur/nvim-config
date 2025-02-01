return {
  {'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }},
  {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup{
       hijack_netrw = true,
            mappings = {
                ["i"] = { 
                    ["<A-n>"] = "create",
                    ["<A-d>"] = "remove",
                    ["<A-r>"] = "rename",
                },
                ["n"] = { -- Normal-Modus
                    ["n"] = "create", 
                    ["d"] = "remove",
                    ["r"] = "rename",
                },
            
            }
      }

    end  
  }
}
    
