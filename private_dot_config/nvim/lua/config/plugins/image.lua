return {
	"3rd/image.nvim",
	enabled = false,
	build = false, -- so that it doesn't build the rock https://github.com/3rd/image.nvim/issues/91#issuecomment-2453430239
	opts = {
		processor = "magick_cli",
	},
}
