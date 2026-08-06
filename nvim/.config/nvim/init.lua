vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.colorcolumn = "120"

vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 0

vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"
vim.o.number = true
vim.opt.relativenumber = true

vim.o.mouse = "a"
vim.opt.wrap = true

vim.opt.spell = true
vim.opt.spelllang = { "en_us" }

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "markdown", "text" },
	callback = function()
		vim.opt_local.spell = true
	end,
})

-- vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Save view (folds, cursor, etc.) only for real files
vim.api.nvim_create_autocmd("BufWinLeave", {
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if ft ~= "oil" and vim.api.nvim_buf_get_name(args.buf) ~= "" then
			vim.cmd("mkview")
		end
	end,
})

-- Load view only for real files
vim.api.nvim_create_autocmd("BufWinEnter", {
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		if ft ~= "oil" and vim.api.nvim_buf_get_name(args.buf) ~= "" then
			vim.cmd("silent! loadview")
		end
	end,
})

-- Shift + LEFT/Right: select next word
vim.api.nvim_set_keymap("i", "<S-Left>", "<Esc>vbgi", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<S-Right>", "<Esc>vwea", { noremap = true, silent = true })

-- -- Auto-close parentheses
-- vim.api.nvim_set_keymap('i', '(', '()<Left>', { noremap = true, silent = true })
--
-- -- Auto-close square brackets
-- vim.api.nvim_set_keymap('i', '[', '[]<Left>', { noremap = true, silent = true })
--
-- -- Auto-close curly braces
-- vim.api.nvim_set_keymap('i', '{', '{}<Left>', { noremap = true, silent = true })
--

-- for wallust
-- vim.opt.termguicolors = true

require("config.plugins.go_modify_tags")
require("config.lazy")
require("config.neovide")

-- Transparent background
-- vim.cmd([[
--   highlight Normal guibg=NONE ctermbg=NONE
--   highlight NormalNC guibg=NONE ctermbg=NONE
--   highlight SignColumn guibg=NONE ctermbg=NONE
--   highlight VertSplit guibg=NONE ctermbg=NONE
--   highlight StatusLine guibg=NONE ctermbg=NONE
-- ]])
--

---
vim.keymap.set("n", "<leader>rr", function()
	vim.cmd("source $MYVIMRC")

	vim.defer_fn(function()
		if type(copyWith) == "function" then
			copyWith()
		else
			vim.notify("copyWith() is not defined after reload", vim.log.levels.ERROR)
		end
	end, 50)
end, { desc = "Reload init.lua and run copyWith()" })

-- Disable F1 key in normal, insert, and visual mode; it conflicts with  my recording hotkey
-- And Alt+Enter for toggle full screen in bspwm
for _, mode in ipairs({ "n", "i", "v" }) do
	vim.keymap.set(mode, "<F1>", "<Nop>", { silent = true })
	vim.keymap.set(mode, "<Alt+Enter>", "<Nop>", { silent = true })
end
