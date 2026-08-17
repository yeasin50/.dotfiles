if not vim.g.neovide then
	return
end
vim.o.guifont = "FiraCode Nerd Font:h25"

local g = vim.g

local function alpha()
	return string.format("%02x", math.floor(255 * (g.transparency or 1)))
end

local opts = {
	transparency = 0.95,
	opacity = 0.95,
	background = "#1f2335",

	blur = 6,
	refresh_rate = 60,
	cursor_vfx = "railgun",
	scale = 1.0,
	hide_mouse = true,
}

g.neovide_line_height = 1.2
g.transparency = opts.transparency
g.neovide_opacity = opts.opacity
g.neovide_background_color = opts.background .. alpha()

g.neovide_floating_blur_amount_x = opts.blur
g.neovide_floating_blur_amount_y = opts.blur
g.neovide_refresh_rate = opts.refresh_rate
g.neovide_cursor_vfx_mode = opts.cursor_vfx
g.neovide_scale_factor = opts.scale
g.neovide_hide_mouse_when_typing = opts.hide_mouse

local function zoom(delta)
	g.neovide_scale_factor = math.max(0.5, g.neovide_scale_factor + delta)
end

vim.keymap.set("n", "<C-+>", function()
	zoom(0.1)
end, { desc = "Neovide Zoom In", silent = true })

vim.keymap.set("n", "<C-_>", function()
	zoom(-0.1)
end, { desc = "Neovide Zoom Out", silent = true })

-- Disable F1 key in normal, insert, and visual mode; it conflicts with  my recording hotkey
-- And Alt+Enter for toggle full screen in bspwm
for _, mode in ipairs({ "n", "i", "v" }) do
	vim.keymap.set(mode, "<F1>", "<Nop>", { silent = true })
	-- vim.keymap.set(mode, "<A-CR>", "<Nop>", { silent = true })
end
