local palette = {
	bg = "#1f1f28",
	fg = "#dcd7ba",
	cursor_bg = "#c8c093",
	cursor_fg = "#c8c093",
	cursor_border = "#c8c093",
	selection_fg = "#c8c093",
	selection_bg = "#2d4f67",
	scrollbar_thumb = "#16161d",
	split = "#16161d",
}

local active_tab = {
	bg_color = palette.bg,
	fg_color = palette.fg,
}

local inactive_tab = {
	bg_color = palette.bg,
	fg_color = palette.fg,
}
return {
	force_reverse_video_cursor = true,
	window_frame = {
		active_titlebar_bg = palette.bg,
		inactive_titlebar_bg = palette.bg,
	},
	colors = {
		foreground = palette.fg,
		background = palette.bg,
		cursor_bg = palette.cursor_bg,
		cursor_fg = palette.cursor_fg,
		cursor_border = palette.cursor_border,
		selection_fg = palette.selection_fg,
		selection_bg = palette.selection_bg,
		scrollbar_thumb = palette.scrollbar_thumb,
		split = palette.split,
		ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
		brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
		indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
		tab_bar = {
			background = palette.bg,
			active_tab = active_tab,
			inactive_tab = inactive_tab,
			inactive_tab_hover = active_tab,
			new_tab = inactive_tab,
			new_tab_hover = active_tab,
		},
	},
}
