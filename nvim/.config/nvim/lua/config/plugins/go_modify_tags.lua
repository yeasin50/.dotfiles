return {
	"ray-x/go.nvim",
	ft = { "go", "gomod" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("go").setup({
			tag_options = "json=", -- JSON tags only
		})
	end,
}
