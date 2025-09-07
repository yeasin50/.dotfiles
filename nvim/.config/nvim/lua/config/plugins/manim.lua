return {
	"yeasin50/manim.nvim",
	dir = "/home/yeasin/github/manim.nvim",
	enabled = true,
	dev = true,
	cmd = "ManimCheck",
	keys = {
		{ "<leader>r", "<cmd>ManimPlay<cr>", desc = "Play Manim class" },
		{ "<leader>re", "<cmd>ManimExport<cr>", desc = "Export manim class" },
	},
	ft = "python",
	config = function()
		require("manim").setup({
			manim_path = "manim",
			venv_path = "/home/yeasin/github/writings/manim/env",
			play_args = { "-pql" },
			export_args = { "-qk --transparent" },
		})
	end,
}
