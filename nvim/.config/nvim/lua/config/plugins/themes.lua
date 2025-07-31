return {
	{
		"folke/tokyonight.nvim",
		enabled = true,
		lazy = false,
		priority = 1000,
		opts = {
			style = "moon", -- Theme variant: "storm", "night", "moon", "day"
			transparent = false,
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
		config = function()
			vim.cmd("colorscheme tokyonight")
		end,
	},

	{
		"joshdick/onedark.vim",
		enabled = false,
		config = function()
			vim.cmd("colorscheme onedark")

			vim.g.onedark_style = "dark" -- Choose style: "dark", "light", "warmer", "cooler"
			vim.g.onedark_terminal_italics = 1

			vim.cmd([[
                highlight SpellBad   guisp=#ff5f5f gui=undercurl
                highlight SpellCap   guisp=#5f87ff gui=undercurl
                highlight SpellLocal guisp=#5fffaf gui=undercurl
                highlight SpellRare  guisp=#d787ff gui=undercurl
            ]])
		end,
	},
}
