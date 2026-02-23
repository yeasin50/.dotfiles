local function get_package_root()
	local dir = vim.fn.expand("%:p:h")
	while dir ~= "/" do
		if vim.fn.filereadable(vim.fn.join({ dir, "pubspec.yaml" }, "/")) == 1 then
			return dir
		end
		dir = vim.fn.fnamemodify(dir, ":h")
	end
	return vim.loop.cwd()
end

return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",

		"nvim-neotest/neotest-go",
		"sidlatau/neotest-dart",
	},
	config = function()
		local neotest = require("neotest")

		neotest.setup({
			adapters = {
				require("neotest-go")({
					args = { "-count=1", "-v" },
					experimental = {
						test_table = true,
					},
				}),
				require("neotest-dart")({
					command = "flutter", -- Command being used to run tests. Defaults to `flutter`
					-- Change it to `fvm flutter` if using FVM
					-- change it to `dart` for Dart only tests
					use_lsp = true, -- When set Flutter outline information is used when constructing test name.
					-- Useful when using custom test names with @isTest annotation
					custom_test_method_names = {},
				}),
			},
		})

		-- Keymaps (same as vim-test style)
		local map = vim.keymap.set
		local opts = { desc = "Neotest", noremap = true, silent = true }

		map("n", "<leader>tn", function()
			vim.cmd("write")
			local cwd
			if vim.bo.filetype == "dart" then
				cwd = get_package_root()
			end
			neotest.run.run({ cwd = cwd })
		end, vim.tbl_extend("force", opts, { desc = "Run nearest test" }))

		map("n", "<leader>tf", function()
			vim.cmd("write")
			local cwd
			if vim.bo.filetype == "dart" then
				cwd = get_package_root()
			end
			neotest.run.run(vim.fn.expand("%"), { cwd = cwd })
		end, vim.tbl_extend("force", opts, { desc = "Run test file" }))

		----
		map("n", "<leader>ts", function()
			vim.cmd("write")
			neotest.run.run(vim.loop.cwd())
		end, vim.tbl_extend("force", opts, { desc = "Run all tests (cwd)" }))

		map("n", "<leader>tl", neotest.run.run_last, vim.tbl_extend("force", opts, { desc = "Run last test" }))
		map(
			"n",
			"<leader>tv",
			neotest.output_panel.toggle,
			vim.tbl_extend("force", opts, { desc = "Toggle output panel" })
		)
	end,
}
