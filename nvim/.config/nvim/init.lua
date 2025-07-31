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
--- dev new gc

-------
local ts_utils = require("nvim-treesitter.ts_utils") --- # dev code action dart

local function get_class_node(root)
	for node in root:iter_children() do
		if node:type() == "class_definition" then
			return node
		end
	end
end

local function get_class_name(class_node)
	local name_node = class_node:field("name")[1]
	return ts_utils.get_node_text(name_node, 0)[1]
end

local function get_class_fields(class_node)
	local ts_query = require("vim.treesitter.query")
	local lang = "dart" -- or whatever language you're using

	local parser = ts.get_parser(0, lang)
	local tree = parser:parse()[1]
	local root = tree:root()

	local query_string = [[
(class_definition
  body: (class_body
          (declaration
            (type_identifier) @ty )) @f )
]]

	local query = ts.query.parse(lang, query_string)
	for id, node, metadata in query:iter_captures(root, 0, 0, -1) do
		local name = query.captures[id] -- e.g., "ty" or "f"
		if name == "ty" then
			local text = vim.treesitter.get_node_text(node, 0)
			print("Found type_identifier: " .. text)
		end
	end
end

local function copyWith()
	local parser = vim.treesitter.get_parser(0, "dart")
	local root = parser:parse()[1]:root()

	local class_node = get_class_node(root)
	if not class_node then
		vim.notify("No class found in file", vim.log.levels.ERROR)
		return
	end

	local class_name = get_class_name(class_node)
	local fields = get_class_fields(class_node)

	print(vim.inspect(fields))
	-- vim.notify("copyWith() added for " .. class_name)
end
--
vim.keymap.set("n", "<leader>rr", function()
	-- vim.cmd("write")
	copyWith()
end, { desc = "reload the config for dev..." })
