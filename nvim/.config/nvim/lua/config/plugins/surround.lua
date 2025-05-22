return {
    "kylechui/nvim-surround",
    version = "*", -- use the latest
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end,
}
