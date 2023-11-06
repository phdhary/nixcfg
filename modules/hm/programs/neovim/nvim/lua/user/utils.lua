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

function M.update_one_line_in_a_file(line_to_match, value_to_write, file_path)
	vim.cmd(string.format("silent !sed -i 's/.*%1s.*/%2s/' %3s", line_to_match, value_to_write, file_path))
end

return M
