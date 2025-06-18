return {
	"epwalsh/obsidian.nvim",
	version = "*",
	lazy = true,
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		workspaces = {
			{
				name = "writings",
				path = "~/github/writings",
			},
		},

		note_path_func = function(spec)
			local current_file = vim.api.nvim_buf_get_name(0)
			local current_dir = vim.fn.fnamemodify(current_file, ":h")
			return string.format("%s/%s.md", current_dir, spec.title)
		end,

		ui = {
			enable = false,
		},
	},
}
