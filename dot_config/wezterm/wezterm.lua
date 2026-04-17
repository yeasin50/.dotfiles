local wezterm = require("wezterm")

return {
	-- FONT (fix bold issue)
	font = wezterm.font_with_fallback({
		{ family = "JetBrains Mono", weight = "Regular" },
		"FiraCode Nerd Font",
		"Noto Sans Bengali",
	}),

	font_size = 15,
	line_height = 1.15,

	font_rules = {
		{
			intensity = "Bold",
			font = wezterm.font("FiraCode Nerd Font", { weight = "Medium" }),
		},
	},

	-- THEME (Tokyo Night)
	color_scheme = "Tokyo Night Storm",

	-- WINDOW LOOK (clean like kitty)
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,

	window_decorations = "NONE | RESIZE",
	window_background_opacity = 0.92,

	window_padding = {
		left = 12,
		right = 12,
		top = 12,
		bottom = 12,
	},

	-- PERFORMANCE / UX
	scrollback_lines = 20000,
	scroll_to_bottom_on_input = true,
	audible_bell = "Disabled",

	term = "xterm-256color",

	-- KEYS (tmux-like control)
	keys = {
		-- panes
		{ key = "h", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "l", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "k", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "j", mods = "ALT", action = wezterm.action.ActivatePaneDirection("Down") },

		{ key = "|", mods = "ALT|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },

		-- font zoom
		{ key = "+", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
		{ key = "0", mods = "CTRL", action = wezterm.action.ResetFontSize },

		-- copy/paste
		{ key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("Clipboard") },
		{ key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },

		-- quick select links
		{ key = "o", mods = "CTRL|SHIFT", action = wezterm.action.QuickSelect },
	},
}
