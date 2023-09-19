local wezterm = require "wezterm"
local M = {}
local act = wezterm.action

for i = 1, 8 do
	table.insert(M, {
		key = tostring(i),
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			local current_index = i - 1
			local tabs = window:mux_window():tabs_with_info()
			local is_tab_exist = false
			for _, tabinfo in pairs(tabs) do
				if tabinfo.index == current_index then
					is_tab_exist = true
				end
			end
			if is_tab_exist then
				window:perform_action(act.ActivateTab(current_index), pane)
			else
				window:perform_action(act.SpawnTab "CurrentPaneDomain", pane)
			end
		end),
	})
end

local select_pane_by_direction = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

for key, direction in pairs(select_pane_by_direction) do
	table.insert(M, {
		key = key,
		mods = "ALT",
		action = act.ActivatePaneDirection(direction),
	})
end

local keybinds = {
	{
		key = "h",
		mods = "LEADER",
		action = act.AdjustPaneSize { "Left", 5 },
	},
	{
		key = "j",
		mods = "LEADER",
		action = act.AdjustPaneSize { "Down", 5 },
	},
	{ key = "k", mods = "LEADER", action = act.AdjustPaneSize { "Up", 5 } },
	{
		key = "l",
		mods = "LEADER",
		action = act.AdjustPaneSize { "Right", 5 },
	},
	{
		key = "Enter",
		mods = "ALT",
		action = act.SplitVertical { domain = "CurrentPaneDomain" },
	},
	{
		key = "m",
		mods = "ALT",
		action = act.TogglePaneZoomState,
	},
	{
		key = "[",
		mods = "LEADER",
		action = act.ActivateCopyMode,
	},
}
for _, value in pairs(keybinds) do
	table.insert(M, value)
end

return M
