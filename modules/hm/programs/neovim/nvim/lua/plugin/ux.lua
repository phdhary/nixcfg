return {
	-- Lua
	{
		"folke/twilight.nvim",
		config = true,
	},
	{
		"echasnovski/mini.bufremove",
		keys = {
			{ "<leader>x", "<CMD>lua require('mini.bufremove').delete(0, false)<CR>" },
			{ "<leader>X", "<CMD>lua require('mini.bufremove').delete(0, true)<CR>" },
		},
	},
	{
		"folke/flash.nvim",
		-- event = "VeryLazy",
		opts = {
			highlight = { backdrop = false },
			modes = {
				char = { enabled = false },
				search = { enabled = false },
			},
		},
    -- stylua: ignore
		keys = {
			-- { "s", mode = { "n", "o", "x" }, function() require("flash").jump { search = { mode = function(str) return "\\<" .. str end, }, } end, desc = "Flash", },
			{ "s", mode = { "n", "o", "x" }, function() require("flash").jump() end , desc = "Flash", },
			-- { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter", },
			{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash", },
			{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search", },
			{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search", },
		},
	},
	{
		"windwp/nvim-spectre",
		config = true,
		keys = {
			{ "<leader>ss", vim.cmd.Spectre },
			{ "<leader>sw", "<CMD>lua require('spectre').open_visual({select_word=true})<CR>" },
			{ "<leader>sp", "<CMD>Spectre %<CR>" },
		},
	},
	{
		-- "Shatur/neovim-session-manager",
		-- event = "VimEnter",
		-- keys = {
		-- 	{ "<leader>fs", "<CMD>SessionManager load_session<CR>" },
		-- 	{ "<leader>ds", "<CMD>SessionManager delete_session<CR>" },
		-- },
		-- config = function()
		-- 	local home_path = os.getenv "HOME"
		-- 	local config_path = vim.fn.stdpath "config"
		-- 	require("session_manager").setup {
		-- 		-- Possible values: Disabled, CurrentDir, LastSession
		-- 		autoload_mode = require("session_manager.config").AutoloadMode.CurrentDir,
		-- 		autosave_ignore_dirs = {
		-- 			"/",
		-- 			"/*",
		-- 			"/*/*",
		-- 			config_path .. "/*",
		-- 			config_path .. "/*/*",
		-- 			config_path .. "/*/*/*",
		-- 			home_path,
		-- 			home_path .. "/Documents",
		-- 			home_path .. "/Documents/*",
		-- 			home_path .. "/Downloads",
		-- 			home_path .. "/Downloads/*",
		-- 			home_path .. "/.local/bin",
		-- 			home_path .. "/.dotfiles",
		-- 			home_path .. "/.config",
		-- 		},
		-- 		autosave_ignore_filetypes = { "gitcommit", "gitrebase", "man" },
		-- 		autosave_ignore_buftypes = { "nofile" },
		-- 	}
		-- end,
	},
	{
		"ethanholz/nvim-lastplace",
		-- event = "BufRead",
		opts = {
			lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
			lastplace_ignore_filetype = {
				"fugitive",
				"gitcommit",
				"gitrebase",
				"svn",
				"hgcommit",
				"fugitive",
				"DiffviewFiles",
				"DiffviewFileHistory",
			},
			lastplace_open_folds = false,
		},
	},
}
