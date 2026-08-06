return {
	"akinsho/pubspec-assist.nvim",
	enabled = false,
	requires = "plenary.nvim",
	config = function()
		require("pubspec-assist").setup()
	end,
}
