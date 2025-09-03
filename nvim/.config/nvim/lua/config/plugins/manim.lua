return {
	"yeasin50/manim.nvim",
	dir = "/home/yeasin/github/manim.nvim",
	enabled = true,
	dev = true,
	cmd = "ManimCheck",
	keys = {
		-- { "<leader>c", "<cmd>ManimCheck<cr>", desc = "Check Manim class/path" },
		{ "<leader>r", "<cmd>ManimPlay<cr>", desc = "Play Manim class" },
	},
	ft = "python",
	config = function()
		require("manim").setup({
			manim_path = "manim",
			venv_path = "/home/yeasin/github/writings/manim/env",
			play_args = { "-pql" },
			export_args = { "-ql" },
		})
	end,
}
