local wezterm = require("wezterm")
return {
	font_dirs = {
		os.getenv("HOME") .. "/.fonts",
		os.getenv("HOME") .. "/.nix-profile/share/fonts/opentype",
		os.getenv("HOME") .. "/.nix-profile/share/fonts/truetype",
	},
	font = wezterm.font_with_fallback({
    -- "JetBrains Mono",
		-- "Liga SFMono Nerd Font",
		-- "Source Code Pro",
		"IBM Plex Mono",
		"Symbols Nerd Font",
	}),
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	font_size = 13,
	line_height = 1.2,
	warn_about_missing_glyphs = false,
}
