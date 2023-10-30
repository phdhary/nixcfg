local M = { mason_packages_path = vim.fn.stdpath "data" .. "/mason/packages" }

function M.get_current_tab_detail()
	local winlist, result = vim.api.nvim_tabpage_list_wins(0), {}
	for _, winid in pairs(winlist) do
		local bufid = vim.api.nvim_win_get_buf(winid)
		result[winid] = { bufid = bufid, ft = vim.fn.getbufvar(bufid, "&filetype") }
	end
	return result
end

function M.reload_package_with_name(package_name)
	for module_name, _ in pairs(package.loaded) do
		if string.find(module_name, "^" .. package_name) then
			package.loaded[module_name] = nil
			require(module_name)
		end
	end
end

function M.hide_long_path(path)
	path = vim.fn.fnamemodify(path:sub(12), ":~:.")
	if not path:match "^~/.dotfiles/" then
		return path
	end
	return path:sub(13)
end

-- function M.update_one_line_in_a_file(file_path, line_to_match, value_to_write)
-- 	local init_cache = {}
-- 	local file = assert(io.open(file_path, "r"))
-- 	for line in file:lines() do
-- 		if line:match(line_to_match) then
-- 			line = ('\t%1s "%2s",'):format(line_to_match, value_to_write)
-- 		end
-- 		table.insert(init_cache, line .. "\n")
-- 	end
-- 	file:close()
-- 	file = assert(io.open(file_path, "w+"))
-- 	for _, line in pairs(init_cache) do
-- 		file:write(line)
-- 	end
-- 	file:close()
-- end

function M.get_curent()
	local file = assert(io.open(os.getenv "HOME" .. "/.config/alacritty/current_theme.yml"))
	local res = ""
	for line in file:lines() do
		if line:match "-" then
			local _, final = line:find "-"
			line = line:gsub("%~", os.getenv "HOME")
			res = line:sub(final + 2)
		end
	end
	return res
end

function M.why()
	local isNormal = false
	local isBright = false
	local polybar_path = os.getenv "HOME" .. "/.config/polybar/gen.ini"
	local file_path = tostring(M.get_curent())
	local init_cache = {}
	local file = assert(io.open(file_path, "r"))
	for line in file:lines() do
		if line == "colors:" then
			line = "[colors]"
		end
		-- if line:match "bright" then
		-- 	line = ""
		-- 	isBright = true
		-- end
		-- if line:match "bright" then
		-- 	line = ""
		-- 	isNormal = true
		-- end
		-- if isBright then
		-- 	line = "bright_" .. line
		-- end
		-- if line:match "primary" or line:match "normal" or line == "bright_" then
		-- 	line = ""
		-- end
		line, _ = line:gsub("%:", "="):gsub("%'", ""):gsub(" ", "")
		table.insert(init_cache, line .. "\n")
	end
	file:close()
	file = assert(io.open(polybar_path, "w+"))
	for _, line in pairs(init_cache) do
		file:write(line)
	end
	file:close()
end

function M.update_one_line_in_a_file(line_to_match, value_to_write, file_path)
	vim.cmd(string.format("silent !sed -i 's/.*%1s.*/%2s/' %3s", line_to_match, value_to_write, file_path))
end

local function sleep(n)
	os.execute("sleep " .. tonumber(n))
end

local function changeAndSleep(c)
	vim.cmd.colorscheme(c)
	sleep(0.1)
end

function M.testcl()
	local allcolors = {
		"ayu",
		"ayu-dark",
		"ayu-mirage",
		"ayu-light",
		"catppuccin",
		"catppuccin-latte",
		"catppuccin-mocha",
		"catppuccin-frappe",
		"catppuccin-macchiato",
		"dayfox",
		"dawnfox",
		"duskfox",
		"nordfox",
		"terafox",
		"nightfox",
		"carbonfox",
		"rose-pine",
		"rose-pine-dawn",
		"rose-pine-main",
		"rose-pine-moon",
		"tokyonight",
		"tokyonight-day",
		"tokyonight-moon",
		"tokyonight-night",
		"tokyonight-storm",
	}
	for _, value in pairs(allcolors) do
		changeAndSleep(value)
	end
end

return M
