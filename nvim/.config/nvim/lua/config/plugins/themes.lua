
return {
  {
    "folke/tokyonight.nvim",
    enabled = false,  
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",     },
  },

  {
    "joshdick/onedark.vim",      
       config = function()

      vim.cmd("colorscheme onedark")

      vim.g.onedark_style = "dark"  -- Choose the style: "dark", "light", "warmer", "cooler"
      vim.g.onedark_terminal_italics = 1  -- Enable italics in terminal

      vim.cmd([[
          highlight SpellBad   guisp=#ff5f5f gui=undercurl
          highlight SpellCap   guisp=#5f87ff gui=undercurl
          highlight SpellLocal guisp=#5fffaf gui=undercurl
          highlight SpellRare  guisp=#d787ff gui=undercurl
    ]])
    end,
  },
}
