local M = {}

local function change_alacritty_theme(theme_name)
	local alacritty_dir = "~/.config/alacritty/"
	local alacritty_colorscheme_file = alacritty_dir .. "current_theme.yml"
	local update = [[  - ~\/.config\/alacritty\/themes\/]] .. theme_name .. ".yml"
	require("user.utils").update_one_line_in_a_file("config", update, alacritty_colorscheme_file)
end

-- stylua: ignore
local function apply_by_bg(themes)
  if vim.o.bg == "dark" then change_alacritty_theme(themes.dark_theme)
  elseif vim.o.bg == "light" then change_alacritty_theme(themes.light_theme)
  end
end

function M.auto()
	local current_colorscheme_name = vim.g.colors_name
	for name, themes in pairs(require "user.feature.terminal_themes") do
		if current_colorscheme_name == name then
			pcall(apply_by_bg, themes.alacritty)
			return
		end
		pcall(change_alacritty_theme, current_colorscheme_name)
	end
end

return M
