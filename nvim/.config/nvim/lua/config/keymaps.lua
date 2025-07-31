vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "open parent directory in Oil" })

-- Move down by two half-pages and center
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Move down by half a page and center" })

-- Move up by two half-pages and center
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Move up by half a page and center" })
vim.keymap.set("v", "<leader>p", '"_dP', { desc = "Paste without removing from  register" })

vim.keymap.set("n", "<leader>f", function()
	require("conform").format({
		lsp_format = "fallback",
	})
end, { desc = "Format code with LSP" })

vim.keymap.set("n", "<leader>cd", function()
	vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
end, { desc = "Show Diagnostics (Cursor Float)" })

vim.api.nvim_create_user_command("BuildRunner", function()
	vim.cmd("botright vsplit | terminal dart pub run build_runner build --delete-conflicting-outputs")
end, {})

-- Flutter
-- vim.keymap.set("n", "<leader>fr", ":FlutterHotReload<CR>", { desc = "Flutter hot reload" })
-- vim.keymap.set("n", "<leader>fR", ":FlutterHotRestart<CR>", { desc = "Flutter hot restart" })
vim.api.nvim_set_keymap("n", "<leader>br", ":BuildRunner<CR>", { noremap = true, silent = true })
