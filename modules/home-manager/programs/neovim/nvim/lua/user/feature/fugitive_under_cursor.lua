local function get_sid(file)
	file = file or "autoload/fugitive.vim"
	file = vim.api.nvim_exec("filter #vim-fugitive/" .. file .. "# scriptnames", true)
	file = string.gsub(file, "^%s*(.-)%s*$", "%1")
	return tonumber(file:match "^(%d+)")
end

return function()
	if vim.bo.ft ~= "fugitive" then
		return
	end
	return get_sid() and vim.call(("<SNR>%d_StageInfo"):format(get_sid()), vim.api.nvim_win_get_cursor(0)[1])
end
