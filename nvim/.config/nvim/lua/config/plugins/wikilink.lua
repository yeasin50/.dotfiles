return {
	"yeasin50/wikilink.nvim",
	enabled = true,
	dir = "/home/yeasin/github/wikilink.nvim",
	dev = true,
	config = function()
		require("wikilink").setup({
			extension = "md", -- optional (default: "md")
			pattern = "%[%[([%w%-%_/%s]+)%]%]", -- optional
			-- location = "~/notes", -- optional, default: current file's directory
		})
	end,
}
