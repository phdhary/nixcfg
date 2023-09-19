-- local wezterm = require "wezterm"

local M = {}

-- M.leader = { key = "a", mods = "CTRL" }
-- M.keys = require "mappings"

for key, value in pairs(require "appearance") do
	M[key] = value
end

for key, value in pairs(require "typeface") do
	M[key] = value
end

return M
