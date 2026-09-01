return {
	"3rd/image.nvim",
	build = false, -- handled by luarocks
	dependencies = {
		{
			"vhyrro/luarocks.nvim",
			priority = 1001,
			opts = {
				rocks = {},
			},
		},
	},
	config = function()
		require("image").setup({
			backend = "kitty", -- WezTerm supports Kitty's graphics protocol natively
			tmux_show_only_in_active_window = true,
			integrations = {
				markdown = {
					enabled = true,
					clear_in_insert_mode = false,
					download_remote_images = true,
				},
			},
			max_width = nil,
			max_height = nil,
			max_width_window_percentage = nil,
			max_height_window_percentage = 50,
			window_overlap_clear_enabled = true,
		})
	end,
}
