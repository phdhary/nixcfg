return {
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "tpope/vim-unimpaired", event = "BufRead" },
	{ "phdhary/nvim-config-lib", dev = false, lazy = true },
	{ import = "plugin.dap" },
	{ import = "plugin.hydra" },
	{ import = "plugin.lsp" },
	-- { "tpope/vim-repeat", event = "BufRead" },
	-- { "nvim-lua/popup.nvim", lazy = true }, -- delsoon
	{
		"christoomey/vim-tmux-navigator",
		keys = {
			{ "<A-h>", vim.cmd.TmuxNavigateLeft },
			{ "<A-l>", vim.cmd.TmuxNavigateRight },
			{ "<A-j>", vim.cmd.TmuxNavigateDown },
			{ "<A-k>", vim.cmd.TmuxNavigateUp },
		},
		init = function()
			vim.g.tmux_navigator_no_mappings = 1
			vim.g.tmux_navigator_no_wrap = 1
			vim.g.tmux_navigator_disable_when_zoomed = 1
		end,
	},
}
