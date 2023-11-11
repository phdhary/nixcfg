return {
	-- { "tpope/vim-abolish", event = "BufRead" },
	{ "nacro90/numb.nvim", config = true, keys = ":" },
	{ "windwp/nvim-autopairs", event = "BufRead", config = true },
	{ "vim-scripts/ReplaceWithRegister", keys = { { "gr", mode = { "n", "v" } } } },
	{ "junegunn/vim-easy-align", keys = { { "ga", "<Plug>(EasyAlign)", mode = { "n", "v" } } } },
	{
		"numToStr/Comment.nvim",
		version = "v0.8.*",
		keys = { { "gc", mode = { "n", "v" } }, { "gb", mode = { "n", "v" } } },
		opts = { pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook() },
		dependencies = "nvim-ts-context-commentstring", -- correcting tsx & jsx comment
	},
	{
		"kylechui/nvim-surround",
		version = "v2.1.2",
		config = true,
		keys = {
			"ys",
			"yS",
			"cs",
			"ds",
			{ "<C-g>s", mode = "i" },
			{ "<C-g>S", mode = "i" },
			{ "S", mode = "v" },
			{ "gS", mode = "v" },
		},
	},
}
