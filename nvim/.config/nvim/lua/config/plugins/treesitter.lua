
return {
  -- Treesitter for syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",  -- Update parsers automatically
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "go", "lua", "json", "bash" },  -- Add more languages if needed
        highlight = {
          enable = true,  -- Enable Treesitter highlighting
        },
      })
    end,
  },
}
