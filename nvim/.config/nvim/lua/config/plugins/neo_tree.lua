return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		cmd = "Neotree",
		keys = {
			{ "<leader>e", ":Neotree toggle<CR>", desc = "Toggle File Explorer" },
		},
		config = function()
			require("neo-tree").setup({
				sources = { "filesystem", "buffers", "git_status", "diagnostics" },
				filesystem = {
					follow_current_file = {
						enabled = true,
					},
					use_libuv_file_watcher = true,
				},
				window = { width = 35 },
				diagnostics = {
					enable = true,
					show_on_dirs = true,
				},
			})

			-- auto-refresh diagnostics in Neo-tree
			vim.api.nvim_create_autocmd({ "DiagnosticChanged" }, {
				callback = function()
					pcall(function()
						require("neo-tree.sources.diagnostics").refresh()
					end)
				end,
			})
		end,
	},

	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim", -- loads after Neo-tree
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},

	{
		"s1n7ax/nvim-window-picker",
		version = "2.*",
		config = function()
			require("window-picker").setup({
				autoselect_one = true,
				filter_rules = {
					include_current_win = false,
					bo = {
						filetype = { "neo-tree", "neo-tree-popup", "notify" },
						buftype = { "terminal", "quickfix" },
					},
				},
			})
		end,
	},
}
