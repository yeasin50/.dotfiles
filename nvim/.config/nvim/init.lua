

vim.g.mapleader = " "
vim.g.maplocalleader = " "


vim.o.number = true
vim.o.relativenumber=true
vim.o.mouse= 'a'


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
require("config.lazy")
