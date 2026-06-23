local M = {}

-- 🔹 Theme selector: 1 = Tokyo Night, 2 = One Dark, 3 = rose-pine, 4 = Wallust
local theme_index = 4

M[1] = {
	"folke/tokyonight.nvim",
	enabled = theme_index == 1,
	lazy = false,
	priority = 1000,
	opts = {
		style = "storm", -- Theme variant: "storm", "night", "moon", "day"
		transparent = true,
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

--  Wallust
M[4] = {
	name = "wallust-theme",
	dir = vim.fn.stdpath("config"),
	enabled = theme_index == 4,
	lazy = false,
	priority = 1000,
	config = function()
		local status_ok, colors = pcall(require, "wallust_theme")
		if not status_ok then
			return
		end

		vim.opt.termguicolors = true
		local set_hl = vim.api.nvim_set_hl

		-- Base Editor Colors
		set_hl(0, "Normal", { bg = colors.bg, fg = colors.fg })
		set_hl(0, "NormalFloat", { bg = colors.color0, fg = colors.fg })
		set_hl(0, "Cursor", { bg = colors.cursor, fg = colors.bg })
		set_hl(0, "LineNr", { fg = colors.color8 })
		set_hl(0, "CursorLine", { bg = colors.color0 })
		set_hl(0, "CursorLineNr", { fg = colors.color4, bold = true })
		set_hl(0, "Visual", { bg = colors.color8, fg = colors.bg })

		-- Syntax Highlighting
		set_hl(0, "Comment", { fg = colors.color8, italic = true })
		set_hl(0, "String", { fg = colors.color2 })
		set_hl(0, "Number", { fg = colors.color3 })
		set_hl(0, "Boolean", { fg = colors.color3 })
		set_hl(0, "Function", { fg = colors.color4 })
		set_hl(0, "Keyword", { fg = colors.color5 })
		set_hl(0, "Type", { fg = colors.color6 })
		set_hl(0, "Statement", { fg = colors.color5 })
		set_hl(0, "Identifier", { fg = colors.color1 })
		set_hl(0, "Constant", { fg = colors.color3 })
		set_hl(0, "Operator", { fg = colors.color5 })
		set_hl(0, "Error", { fg = colors.color1, bold = true })

		-- UI Elements
		set_hl(0, "WinSeparator", { fg = colors.color0 })
		set_hl(0, "StatusLine", { bg = colors.color0, fg = colors.fg })
		set_hl(0, "StatusLineNC", { bg = colors.bg, fg = colors.color8 })
		set_hl(0, "Pmenu", { bg = colors.color0, fg = colors.fg })
		set_hl(0, "PmenuSel", { bg = colors.color4, fg = colors.bg })
	end,
}
return M
