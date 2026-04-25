return {
	"stevearc/oil.nvim",
	opts = {
		default_file_explorer = true,
		view_options = {
			show_hidden = true,
			natural_order = "fast",
			is_hidden_file = function(name, bufnr)
				return name:match("^%.")
			end,
			is_always_hidden = function(name, bufnr)
				return false
			end,
			sort = { { "type", "asc" }, { "name", "asc" } },
		},
		float = {
			border = "rounded",
			get_config = function()
				local width = math.floor(vim.o.columns * 0.8)
				local height = math.floor(vim.o.lines * 0.8)
				local row = math.floor((vim.o.lines - height) / 2)
				local col = math.floor((vim.o.columns - width) / 2)
				return {
					relative = "editor",
					width = width,
					height = height,
					row = row,
					col = col,
					border = "rounded",
				}
			end,
		},
		preview_win = {
			update_on_cursor_moved = true,
			preview_method = "fast_scratch",
			disable_preview = function(filename)
				return false
			end,
			win_options = {},
		},
		confirmation = {
			max_width = 0.9,
			min_width = { 40, 0.4 },
			max_height = 0.9,
			min_height = { 5, 0.1 },
		},
	},
	dependencies = { { "echasnovski/mini.icons", opts = {} } },
	lazy = false,
}
