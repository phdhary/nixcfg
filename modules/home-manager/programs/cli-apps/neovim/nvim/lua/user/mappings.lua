vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv", { silent = true })
vim.keymap.set("n", "N", "Nzzzv", { silent = true })
vim.keymap.set("n", "*", "*N")
vim.keymap.set("n", "#", "#N")

-- vim.keymap.set("n", "<C-,>", "8<C-w><")
-- vim.keymap.set("n", "<C-.>", "8<C-w>>")
-- vim.keymap.set("n", "<C-=>", "2<C-w>+")
-- vim.keymap.set("n", "<C-->", "2<C-w>-")

vim.keymap.set("n", "<C-c>", ":%y+<CR>")
vim.keymap.set("n", "<leader>rp", "*Ncgn")
vim.keymap.set("n", "<leader>wa", vim.cmd.wa)
vim.keymap.set("n", "<leader>bn", vim.cmd.enew)
vim.keymap.set("n", "<leader>qa", "<CMD>quitall!<CR>")
vim.keymap.set("n", "<leader>cn", "<CMD>e $MYVIMRC | cd %:p:h<CR>")
vim.keymap.set("n", "<leader>bca", "<CMD>%bd|e#<CR>")
vim.keymap.set("n", "<leader>qf", vim.cmd.QuickfixToggle)
vim.keymap.set("n", "<leader>ll", vim.cmd.LoclistToggle)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

-- vim.keymap.set("n", "<A-h>", "<C-w>h")
-- vim.keymap.set("n", "<A-j>", "<C-w>j")
-- vim.keymap.set("n", "<A-k>", "<C-w>k")
-- vim.keymap.set("n", "<A-l>", "<C-w>l")

vim.keymap.set("i", "<A-h>", "<Left>")
vim.keymap.set("i", "<A-j>", "<Down>")
vim.keymap.set("i", "<A-k>", "<Up>")
vim.keymap.set("i", "<A-l>", "<Right>")
vim.keymap.set("i", "<Tab>", "<Right>")
vim.keymap.set("i", "<S-Tab>", "<Left>")

vim.keymap.set({ "n", "i" }, "<C-s>", function()
	if vim.bo.filetype == "TelescopePrompt" then
		return
	end
	vim.cmd.update()
end)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("t", "<C-e>", [[<C-\><C-n>]])

vim.keymap.set("n", "<Esc>", function()
	if vim.api.nvim_win_get_config(0).relative ~= "" then
		vim.api.nvim_win_close(0, true)
	else
		vim.cmd.nohlsearch()
	end
end)

local isZoomed = false
vim.keymap.set("n", "<C-w>m", function()
	if isZoomed then
		vim.cmd "vertical wincmd =|horizontal wincmd ="
		isZoomed = false
	else
		vim.cmd "resize|vertical resize"
		isZoomed = true
	end
end)

vim.keymap.set("n", "yof", function()
	if vim.opt_local.foldenable._value then
		vim.cmd.setlocal "nofoldenable"
	else
		vim.cmd.setlocal "foldenable"
	end
	vim.cmd.setlocal "foldenable?"
end)
