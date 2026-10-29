return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = false,
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.icons",
		},
		opts = {},
	},

	{
		"brianhuster/live-preview.nvim",
		enabled = true,
		config = function()
			require("live-preview").setup({
				port = 5500,
			})
		end,
	},
}
