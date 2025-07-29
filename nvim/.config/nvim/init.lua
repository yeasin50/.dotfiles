

vim.g.mapleader = " "
vim.g.maplocalleader = " "


vim.o.number = true
vim.o.relativenumber=true
vim.o.mouse= 'a'

vim.o.encoding = "utf-8"
vim.o.fileencoding = "utf-8"

vim.opt.clipboard = "unnamedplus"

vim.opt.wrap = true

vim.opt.spell = true 
vim.opt.spelllang = {"en_us"}


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


vim.opt.guifont = "Fira Code Medium,Noto Sans Bengali Regular:h14"

-- Shift + Left: select previous word
vim.api.nvim_set_keymap('i', '<S-Left>', '<Esc>vbgi', { noremap = true, silent = true })

-- Shift + Right: select next word
vim.api.nvim_set_keymap('i', '<S-Right>', '<Esc>vwea', { noremap = true, silent = true })

-- -- Auto-close parentheses
-- vim.api.nvim_set_keymap('i', '(', '()<Left>', { noremap = true, silent = true })
--
-- -- Auto-close square brackets
-- vim.api.nvim_set_keymap('i', '[', '[]<Left>', { noremap = true, silent = true })
--
-- -- Auto-close curly braces
-- vim.api.nvim_set_keymap('i', '{', '{}<Left>', { noremap = true, silent = true })
--

-- Transparent background
vim.cmd [[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight VertSplit guibg=NONE ctermbg=NONE
  highlight StatusLine guibg=NONE ctermbg=NONE
]]


require("config.lazy")
