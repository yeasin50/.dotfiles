return {
	"Pocco81/high-str.nvim",
	keys = {
		-- Highlight visual selection (opens a small menu to pick color index)
		{ "H", ":<C-U>HSHighlight<CR>", mode = "v", desc = "HighStr: Highlight Selection" },
		-- Remove highlight from visual selection
		{ "<leader>hr", ":<C-U>HSRmHighlight<CR>", mode = "v", desc = "HighStr: Remove Highlight" },
		-- Remove all highlights in current buffer
		{ "<leader>ha", ":HSRmHighlight rm_all<CR>", mode = "n", desc = "HighStr: Clear All" },
	},
	opts = {
		verbosity = 0,
		saving_path = vim.fn.stdpath("data") .. "/high-str/",
		highlight_colors = {
			color_1 = { "#e2e2e2", "smart" }, -- Background, Foreground ("smart" auto-calculates contrast)
			color_2 = { "#abb2bf", "smart" },
			color_3 = { "#e06c75", "smart" },
			color_4 = { "#98c379", "smart" },
			color_5 = { "#e5c07b", "smart" },
			color_6 = { "#61afef", "smart" },
			color_7 = { "#c678dd", "smart" },
			color_8 = { "#56b6c2", "smart" },
			color_9 = { "#ffffff", "smart" },
		},
	},
	config = function(_, opts)
		require("high-str").setup(opts)
	end,
}
