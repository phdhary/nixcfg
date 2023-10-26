local auto_save_flag = false
vim.api.nvim_create_autocmd("CursorHold", {
	group = "General",
	pattern = "*.*",
	callback = function()
		local filename = vim.fn.expand "%"
		if not auto_save_flag then
			return
		elseif
			vim.bo.modifiable -- is modifiable
			and not (filename ~= "" and vim.bo.buftype == "" and vim.fn.filereadable(filename) == 0) -- not a new file
			and not (filename == "") -- not an unnamed file
			and not vim.bo.readonly -- not readonly
		then
			vim.cmd.update()
		end
	end,
	desc = "autosaver",
})
vim.keymap.set("n", "yoa", function()
	auto_save_flag = not auto_save_flag
	vim.notify("auto save " .. (auto_save_flag and "on" or "off"))
end)
