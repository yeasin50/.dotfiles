return {
	"ray-x/go.nvim",
	ft = { "go", "gomod" },
	dependencies = {
		"ray-x/guihua.lua",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"neovim/nvim-lspconfig",
	},
	config = function()
		require("go").setup({
			tag_options = "json=", -- JSON tags only
			lsp_codelens = false, -- Add this line to fix the error
		})
	end,
}
