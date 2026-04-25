local M = {}

-- 🔹 Theme selector: 1 = Tokyo Night, 2 = One Dark, 3 = rose-pine
local theme_index = 1

M[1] = {
	"folke/tokyonight.nvim",
	enabled = theme_index == 1,
	lazy = false,
	priority = 1000,
	opts = {
		style = "storm", -- Theme variant: "storm", "night", "moon", "day"
		transparent = false,
		styles = { sidebars = "transparent", floats = "transparent" },
	},
	config = function()
		vim.cmd("colorscheme tokyonight")
	end,
}

M[2] = {
	"joshdick/onedark.vim",
	enabled = theme_index == 2,
	config = function()
		vim.cmd("colorscheme onedark")
		vim.g.onedark_style = "dark"
		vim.g.onedark_terminal_italics = 1
	end,
}

M[3] = {
	"rose-pine/neovim",
	enabled = theme_index == 3,
	name = "rose-pine",
	config = function()
		vim.cmd("colorscheme rose-pine")
	end,
}
return M
