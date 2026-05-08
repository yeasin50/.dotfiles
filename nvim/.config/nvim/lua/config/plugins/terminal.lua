return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			open_mapping = [[<c-\>]],
			direction = "float", -- "vertical", -- float
			shade_terminals = true,
			shading_factor = 50,
			float_opts = {
				border = "rounded",
				width = function()
					return math.floor(vim.o.columns * 0.95)
				end,
				height = function()
					return math.floor(vim.o.lines * 0.9)
				end,
			},
		},
	},
}
