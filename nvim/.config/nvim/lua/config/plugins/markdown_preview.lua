return {
	"iamcco/markdown-preview.nvim",
	enabled = false,
	build = "cd app && npm install",
	ft = { "markdown" },
	config = function()
		vim.g.mkdp_auto_start = 1 -- auto-open preview
	end,
}
