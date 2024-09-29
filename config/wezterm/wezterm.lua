local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.window_close_confirmation = "NeverPrompt"

config.font = wezterm.font_with_fallback({
	{ family = "FiraCode Nerd Font Mono", weight = "Medium" },
	{ family = "Noto Sans CJK JP" },
})
config.font_size = 10

config.initial_rows = 59
config.initial_cols = 110

config.color_scheme = "Breeze"
config.colors = {
	background = "black",
}

local act = wezterm.action
config.keys = {
	{ mods = "SHIFT", key = "LeftArrow", action = act.ActivateTabRelative(-1) },
	{ mods = "SHIFT", key = "RightArrow", action = act.ActivateTabRelative(1) },
	{ mods = "SHIFT|CTRL", key = "LeftArrow", action = act.MoveTabRelative(-1) },
	{ mods = "SHIFT|CTRL", key = "RightArrow", action = act.MoveTabRelative(1) },
}

return config
