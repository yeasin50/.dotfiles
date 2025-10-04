vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.clipboard:append("unnamedplus")

vim.o.number = true

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

vim.opt.guifont = "Fira Code Medium:h14"

vim.api.nvim_set_keymap("i", "<S-Left>", "<Esc>vbgi", { noremap = true, silent = true })

-- Shift + Right: select next word
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

require("config.lazy")
-- Transparent background
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight VertSplit guibg=NONE ctermbg=NONE
  highlight StatusLine guibg=NONE ctermbg=NONE
]])

-- For neovide

local alpha = function()
	return string.format("%x", math.floor(255 * (vim.g.transparency or 0.8)))
end

vim.g.transparency = 0.0
vim.g.neovide_opacity = 0.70
vim.g.neovide_background_color = "#1f2335" --- .. alpha()

-- vim.g.neovide_floating_blur_amount_x = 6.0
-- vim.g.neovide_floating_blur_amount_y = 6.0
-- vim.g.neovide_refresh_rate = 60
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_scale_factor = 1.0
vim.g.neovide_hide_mouse_when_typing = true
---

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

-- Disable F1 key in normal, insert, and visual mode
vim.api.nvim_set_keymap("n", "<F1>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<F1>", "<Nop>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<F1>", "<Nop>", { noremap = true, silent = true })
