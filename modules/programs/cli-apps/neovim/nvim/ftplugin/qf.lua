local is_loclist = vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0
if not is_loclist then
	vim.cmd "wincmd J"
end

vim.opt_local.relativenumber = false
local min_height = 3
local max_height = 10
local lines = vim.fn.line "$"
local height = vim.fn.max { vim.fn.min { lines, max_height }, min_height }
vim.api.nvim_win_set_height(0, height)

local function return_to_qf()
	for winid, tbl in pairs(require("user.utils").get_current_tab_detail()) do
    -- stylua: ignore
    if tbl.ft == "qf" then vim.api.nvim_set_current_win(winid) end
	end
end

local opts = { silent = true, buffer = true }
vim.keymap.set("n", "<C-j>", function()
	if is_loclist then pcall(vim.cmd.lnext) else pcall(vim.cmd.cnext) end
	return_to_qf()
end, opts)
vim.keymap.set("n", "<C-k>", function ()
	if is_loclist then pcall(vim.cmd.lprevious) else pcall(vim.cmd.cprevious) end
	return_to_qf()
end, opts)
vim.keymap.set("n", "<CR>", is_loclist and "<CR><CMD>lclose<CR>" or "<CR><CMD>cclose<CR>", opts)
vim.keymap.set("n", "q", is_loclist and vim.cmd.lclose or vim.cmd.cclose, opts)
vim.keymap.set("n", "o", "<CR>", opts)
vim.keymap.set("n", "gg", function()
	vim.cmd(is_loclist and "lfirst" or "cfirst")
	return_to_qf()
end, opts)
vim.keymap.set("n", "G", function()
	vim.cmd(is_loclist and "llast" or "clast")
	return_to_qf()
end, opts)
vim.keymap.set("n", "<Tab>", function()
	vim.cmd "normal o"
	return_to_qf()
end, opts)
