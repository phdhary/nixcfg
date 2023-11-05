vim.api.nvim_create_user_command("ReloadConfig", function()
	require("user.utils").reload_package_with_name "user"
	if vim.g.colors_name ~= require("user.config").colorscheme then
		vim.defer_fn(function()
			vim.cmd.colorscheme(require("user.config").colorscheme)
		end, 5)
	end
end, { desc = "reload neovim config" })

vim.api.nvim_create_user_command("FugitiveWindowOnly", function()
	for winid, tbl in pairs(require("user.utils").get_current_tab_detail()) do
		if tbl.ft == "fugitive" then
			vim.api.nvim_set_current_win(winid)
			vim.cmd "wincmd o"
		end
	end
end, { desc = "close fugitive diff" })

vim.api.nvim_create_user_command("QuickfixToggle", function()
	for _, tbl in pairs(require("user.utils").get_current_tab_detail()) do
		if tbl.ft == "qf" then
			vim.cmd.cclose()
			return
		end
	end
	vim.cmd.copen()
end, { desc = "toggle quickfix" })

vim.api.nvim_create_user_command("LoclistToggle", function()
	for _, tbl in pairs(require("user.utils").get_current_tab_detail()) do
		if tbl.ft == "qf" then
			vim.cmd.lclose()
			return
		end
	end
	if #vim.fn.getloclist(0) > 0 then
		vim.cmd.lopen()
	end
end, { desc = "toggle loclist" })

vim.api.nvim_create_user_command("DiagnosticToggle", function()
	local config = vim.diagnostic.config
	local vt = config().virtual_text
	config {
		virtual_text = not vt,
		underline = not vt,
		signs = not vt,
	}
end, { desc = "toggle diagnostic" })
