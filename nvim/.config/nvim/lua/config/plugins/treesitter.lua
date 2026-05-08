return {
	"nvim-treesitter/nvim-treesitter",
	run = ":TSUpdate",
	branch = "master",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "go", "lua", "json", "bash", "dart", "yaml", "java" }, -- Add more languages if needed
			highlight = {
				enable = true, -- Enable Treesitter highlighting
			},
		})
	end,
}
