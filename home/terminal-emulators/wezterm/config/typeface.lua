local wezterm = require "wezterm"
return {
	font_dirs = { os.getenv "HOME" .. "/.fonts" },
	font = wezterm.font_with_fallback { "IBM Plex Mono", "Symbols Nerd Font" },
	harfbuzz_features = {
		"calt=0",
		"clig=0",
		"liga=0",
	},
	font_size = 16,
	line_height = 1.2,
	warn_about_missing_glyphs = false,
}
