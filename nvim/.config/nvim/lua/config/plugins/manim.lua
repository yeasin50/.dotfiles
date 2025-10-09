return {
	"yeasin50/manim.nvim",
	dir = "/home/yeasin/github/manim.nvim",
	enabled = true,
	dev = true,
	cmd = "ManimCheck",
	keys = {
		{ "<leader>re", "<cmd>ManimExport<cr>", desc = "Export manim class" },
	},
	ft = "python",
	config = function()
		require("manim").setup({
			manim_path = "manim",
			-- /home/yeasin/github/writings/manim/env -qk --transparent --fps=30  --media_dir=/home/yeasin/Videos/raw/manim_output
			venv_path = "/home/yeasin/github/writings/manim/env",
			play_lines = 4,
			play_args = { "-pql" },
			export_args = {
				"-qk",
				"--media_dir=/home/yeasin/Videos/raw/manim_output",
				"--transparent",
				"--fps=30",
			},
			project_config = {
				resolution = { 3840, 2160 }, -- width x height
				fps = 30, -- frames per second
				transparent = true, -- background transparency
				export_dir = "/home/yeasin/Videos/raw/manim_output/",
				max_workers = 4, -- use cores
				ignore_files = {
					"common.py",
					"export.py",
					"extract_marker.py",
				}, -- files to skip
				failed_list_file = "failed_files.txt",
			},
		})
	end,
}
