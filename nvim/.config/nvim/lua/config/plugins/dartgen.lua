return {
	"yeasin50/dartgen.nvim",
	enabled = true,
	dir = "/home/yeasin/github/dartgen.nvim",
	dev = true,
	config = function()
		require("dartgen.commands").setup()
	end,
}
