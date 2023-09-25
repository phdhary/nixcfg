local M = {}

-- M.leader = { key = "a", mods = "CTRL" }

for key, value in pairs(require("config.mappings")) do
	M[key] = value
end

for key, value in pairs(require("config.appearance")) do
	M[key] = value
end

for key, value in pairs(require("config.typeface")) do
	M[key] = value
end

return M
