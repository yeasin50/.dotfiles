vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "open parent directory in Oil" })

-- Move up by two half-pages and center
vim.keymap.set("n", "<C-u>", function()
	local lines = math.floor(vim.fn.winheight(0) / 4) -- 25% of window height
	vim.cmd("normal! " .. lines .. "kzz") -- move up and center
end, { desc = "Move up by 25% of a page and center" })

vim.keymap.set("n", "<C-q>", "<cmd>bd<CR>", { desc = "Close current buffer" })

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

---  switch  to buffer
function _G.goto_buffer(n)
	local buffers = {}
	for _, buf in ipairs(vim.fn.getbufinfo({ buflisted = 1 })) do
		if vim.api.nvim_buf_is_loaded(buf.bufnr) then
			table.insert(buffers, buf.bufnr)
		end
	end
	if n <= #buffers then
		vim.api.nvim_set_current_buf(buffers[n])
	end
end

-- mappings
for i = 1, 9 do
	vim.api.nvim_set_keymap(
		"n",
		"<M-" .. i .. ">",
		string.format([[<cmd>lua _G.goto_buffer(%d)<CR>]], i),
		{ noremap = true, silent = true }
	)
end
