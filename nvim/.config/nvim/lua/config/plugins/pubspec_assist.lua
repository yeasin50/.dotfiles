return {
	"akinsho/pubspec-assist.nvim",
	requires = "plenary.nvim",
	config = function()
		require("pubspec-assist").setup()
	end,
}
