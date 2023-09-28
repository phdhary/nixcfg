local wezterm = require("wezterm")
local act = wezterm.action

local default_key_tables = wezterm.gui.default_key_tables()
local copy_mode = default_key_tables.copy_mode

local copy_mode_extra = {
	key = "Escape",
	mods = "NONE",
	action = act.Multiple({
		act.ClearSelection,
		act.CopyMode "ClearSelectionMode" ,
	}),
	-- action = act.DisableDefaultAssignment,
}

table.insert(copy_mode, copy_mode_extra)

return {
	keys = {
		{
			key = "i",
			mods = "SHIFT|CTRL",
			action = act.CharSelect({
				copy_on_select = true,
				copy_to = "ClipboardAndPrimarySelection",
			}),
		},
		{
			key = "m",
			mods = "SHIFT|CTRL",
			action = wezterm.action.DisableDefaultAssignment,
		},
	},
	key_tables = { copy_mode = copy_mode },
}
