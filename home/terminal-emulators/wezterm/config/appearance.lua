local wezterm = require "wezterm"

wezterm.on("format-tab-title", function(
	tab --[[ , tabs, panes, config, hover, max_width ]]
)
	if tab.is_active then
		return {
			{ Text = "[" .. tab.tab_index + 1 .. " " .. tab.active_pane.title .. "]" },
		}
	end
	return {
		{ Text = " " .. tab.tab_index + 1 .. " " .. tab.active_pane.title .. " " },
	}
end)

return {
	color_scheme = require("config.colorscheme").color_scheme,
-- color_scheme_dirs = { '/home/laken/.config.wezterm/colors' },

	default_cursor_style = "BlinkingBlock",
	force_reverse_video_cursor = true,
	cursor_thickness = 2,
	animation_fps = 1,
	cursor_blink_rate = 500,
	-- cursor_blink_ease_in = "EaseOut",
	-- cursor_blink_ease_out = "Linear",
	window_decorations = "RESIZE",
	window_padding = {
		left = 3,
		right = 0,
		top = 0,
		bottom = 0,
	},
	tab_bar_at_bottom = false,
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,
	initial_rows = 20,
	initial_cols = 100,
}
