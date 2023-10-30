local autocmd = vim.api.nvim_create_autocmd
local group = vim.api.nvim_create_augroup("General", { clear = true })

autocmd("TermOpen", {
	group = group,
	callback = function()
		vim.opt_local.nu = false
		vim.opt_local.rnu = false
		vim.cmd "startinsert!"
	end,
	desc = "terminal things",
})

autocmd("TextYankPost", {
	group = group,
	command = "lua vim.highlight.on_yank()",
	desc = "highlight on copy",
})

autocmd("FileType", {
	group = group,
	pattern = "checkhealth,git,help,spectre_panel,dap-float",
	callback = function()
		vim.keymap.set("n", "q", "ZQ", { buffer = true })
	end,
	desc = "exit with `q`",
})

autocmd("FileType", {
	group = group,
	pattern = "rasi",
	callback = function()
		vim.opt_local.commentstring = "// %s"
	end,
	desc = "rasi things",
})

autocmd("FileType", {
	group = group,
	pattern = "yuck",
	callback = function()
		vim.opt_local.commentstring = ";; %s"
	end,
	desc = "yuck things",
})

autocmd("FileType", {
	group = group,
	pattern = "help,man",
	callback = function()
		vim.keymap.set({ "n", "v" }, "u", "<C-u>zz", { buffer = true })
		vim.keymap.set({ "n", "v" }, "d", "<C-d>zz", { buffer = true, nowait = true })
	end,
	desc = "scroll up and down like a pager",
})

autocmd("FileType", {
	group = group,
	pattern = "fugitive",
	callback = function()
		vim.opt_local.nu = false
		vim.opt_local.rnu = false
		vim.keymap.set("n", "<Tab>", "<Plug>fugitive:=", { buffer = true })
		vim.keymap.set("n", "<C-j>", "<Plug>fugitive:)", { buffer = true })
		vim.keymap.set("n", "<C-k>", "<Plug>fugitive:(", { buffer = true })
		vim.keymap.set("n", "dw", "<Plug>fugitive:dv|:wincmd J<CR>", { silent = true, buffer = true })
		vim.keymap.set("n", "q", "<Plug>fugitive:gq", { buffer = true })
		vim.keymap.set("n", "D", function()
			local info = require "user.feature.fugitive_under_cursor"()
			if info then
				if #info.paths > 0 then
					vim.cmd(("DiffviewOpen --selected-file=%s"):format(vim.fn.fnameescape(info.paths[1])))
				elseif info.commit ~= "" then
					vim.cmd(("DiffviewOpen %s^!"):format(info.commit))
				end
			end
		end, { buffer = true })
	end,
	desc = "mappings and options",
})

autocmd("FileType", {
	group = group,
	pattern = "git",
	callback = function()
		vim.keymap.set("n", "D", function()
			vim.cmd(("DiffviewOpen %s^!"):format(vim.fn.expand "<cWORD>"))
		end, { buffer = true })
	end,
	desc = "open Diffview for the item under the cursor",
})

autocmd("FileType", {
	group = group,
	pattern = "fugitive,git",
	callback = function()
		vim.keymap.set("n", "<C-v>", "<Plug>fugitive:gO", { buffer = true })
		vim.keymap.set("n", "<C-x>", "<Plug>fugitive:o", { buffer = true })
		vim.keymap.set("n", "<C-t>", "<Plug>fugitive:O", { buffer = true })
	end,
	desc = "split mappings",
})

autocmd("FileType", {
	group = group,
	pattern = "fugitiveblame",
	callback = function()
		vim.keymap.set("n", "<C-x>", "o", { remap = true, buffer = true })
		vim.keymap.set("n", "<C-t>", "O", { remap = true, buffer = true })
		vim.keymap.set("n", "q", "<Plug>fugitive:gq", { buffer = true })
	end,
	desc = "split mappings",
})

autocmd("FileType", {
	group = group,
	pattern = "markdown",
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.conceallevel = 0
	end,
	desc = "options",
})

autocmd("FileType", {
	group = group,
	pattern = "DressingInput",
	callback = function()
		vim.keymap.set("n", "o", "<Nop>", { buffer = true })
	end,
	desc = "options",
})

-- autocmd("OptionSet", {
-- 	group = group,
-- 	pattern = "background",
-- 	callback = function()
-- 		local current = require("user.config").colorscheme
-- 		local a = { "rose-pine", "rose-pine-main", "rose-pine-moon" }
-- 		for _, value in pairs(a) do
-- 			if vim.o.background == "light" and current == value then
-- 				vim.cmd.colorscheme "rose-pine-dawn"
-- 			end
-- 			if vim.o.background == "dark" and current == value then
-- 				vim.cmd.colorscheme(value)
-- 			end
-- 		end
-- 	end,
-- 	desc = "rose-pine bg",
-- })

autocmd("ColorScheme", {
	group = group,
	callback = function()
		local config_file_path = vim.fn.stdpath "config" .. "/lua/user/config.lua"
		local current_colorscheme = require("user.config").colorscheme
		local utils = require "user.utils"
		utils.update_one_line_in_a_file(
			"colorscheme",
			string.format([[\tcolorscheme = "%s",]], current_colorscheme),
			config_file_path
		)
		-- require("user.feature.alacritty").auto()
		-- require("user.feature.alacritty").auto2()
		-- vim.cmd "silent !killall -USR1 nvim" -- send signal to all nvim
	end,
	desc = "auto alacritty theme",
})

autocmd("ColorScheme", {
	group = group,
	callback = function()
		local set_hl = vim.api.nvim_set_hl
		-- nvim-tree hl to neo-tree
		set_hl(0, "NeoTreeDirectoryIcon", { link = "NvimTreeFolderIcon" })
		set_hl(0, "NeoTreeDirectoryIcon", { link = "NvimTreeFolderIcon" })
		set_hl(0, "NeoTreeDirectoryName", { link = "NvimTreeFolderName" })
		set_hl(0, "NeoTreeDirectoryName", { link = "NvimTreeOpenedFolderName" })
		set_hl(0, "NeoTreeFileNameOpened", { link = "NvimTreeOpenedFile" })
		set_hl(0, "NeoTreeRootName", { link = "NvimTreeRootFolder" })
		set_hl(0, "NeoTreeSymbolicLinkTarget", { link = "NvimTreeSymlink" })
		-- float border
		set_hl(0, "HarpoonBorder", { link = "FloatBorder" })
		set_hl(0, "HarpoonWindow", { link = "NormalFloat" })
		set_hl(0, "LspInfoBorder", { link = "FloatBorder" })
		set_hl(0, "NullLsInfoBorder", { link = "FloatBorder" })
		-- hydra
		set_hl(0, "HydraBorder", { bold = true, link = "FloatBorder" })
		set_hl(0, "HydraHint", { bold = true, link = "NormalFloat" })
		set_hl(0, "HydraAmaranth", { bold = true, fg = "#ff1757" })
		set_hl(0, "HydraBlue", { bold = true, fg = "#5ebcf6" })
		set_hl(0, "HydraPink", { bold = true, fg = "#ff55de" })
		set_hl(0, "HydraRed", { bold = true, fg = "#ff5733" })
		set_hl(0, "HydraTeal", { bold = true, fg = "#00a1a1" })
	end,
	desc = "adjust highlight",
})

local function set_ft(pattern, ft)
	autocmd("BufEnter", {
		group = group,
		pattern = pattern,
		callback = function()
			vim.bo.filetype = vim.bo.filetype ~= ft and ft or vim.bo.filetype
		end,
		desc = string.format("set ft of %1s file to %2s", pattern, ft),
	})
end

set_ft("*.arb", "json")
set_ft("*.yuck", "yuck")
set_ft("*.rasi", "rasi")

autocmd("BufWritePost", {
	group = group,
	pattern = vim.fn.stdpath "config" .. "/lua/user/*.lua",
	callback = function()
		local package_name = vim.fn.fnamemodify(vim.fn.expand "%", ":.:r"):gsub("lua", ""):gsub("/", "."):sub(2)
		if package_name == "user.config" then
			vim.cmd.ReloadConfig()
			return
		elseif package_name == "user.snippets" then
			require("luasnip").cleanup()
			require("luasnip.loaders.from_vscode").lazy_load()
		end
		require("user.utils").reload_package_with_name(package_name)
	end,
	desc = "auto reload lua/user/* on save",
})

autocmd("DiagnosticChanged", {
	group = group,
	callback = function()
		vim.diagnostic.setloclist { open = false, title = "diagnostics" }
	end,
	desc = "update loclist",
})

autocmd("User", {
	group = group,
	pattern = "LazyVimStarted",
	callback = function()
		vim.cmd.colorscheme(require("user.config").colorscheme)
		vim.cmd.doautocmd "ColorScheme" -- for triggering hl adjustment autocmds
	end,
	desc = "set colorscheme on enter",
})

autocmd("Signal", {
	group = group,
	pattern = "SIGUSR1",
	callback = function()
		require("user.utils").reload_package_with_name "user.config"
		local current_colorscheme = require("user.config").colorscheme
		if vim.g.colors_name == current_colorscheme then
			return
		end
		vim.cmd.colorscheme(current_colorscheme)
		vim.cmd.redraw()
		-- vim.print("got this: " .. require("user.config").colorscheme)
	end,
	desc = "change colorscheme of all nvim instance",
})
