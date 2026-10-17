return {
	"eatgrass/colorizer",
	config = function()
		require("colorizer").setup({
			filetypes = {
				"*",
			},
			user_default_options = {
				AARRGGBB = true,
				mode = "background",
			},
		})
	end,
}
