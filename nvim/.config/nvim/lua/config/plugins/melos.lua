return {
	"yeasin50/melos.nvim",
	dir = "/home/yeasin/github/melos.nvim",
	dev = true,
	cmd = { "MelosInit" }, -- Lazy will load the plugin when you type :MelosInit
	config = function()
		require("melos").setup() -- Optional: Call setup when it loads
	end,
}
