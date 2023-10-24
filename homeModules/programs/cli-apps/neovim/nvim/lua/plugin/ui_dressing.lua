return {
	"stevearc/dressing.nvim",
	event = "UIEnter", -- can cause the starting screen to dissappear if VeryLazy
	opts = {
		input = {
			insert_only = false, -- When true, <Esc> will close the modal
			border = require("user.config").border,
			win_options = { winblend = 0, wrap = false },
			get_config = function(opts)
				return { min_width = string.len(opts.prompt) + 4 }
			end,
			mappings = {
				n = { ["<C-j>"] = "Confirm" },
				i = { ["<C-j>"] = "Confirm" },
			},
		},
		select = {
			backend = { "telescope", "builtin" },
			builtin = { border = require("user.config").border, win_options = { winblend = 0 } },
			get_config = function(opts)
				if opts.kind == "codeaction" then
					return { telescope = require("telescope.themes").get_dropdown {} }
				elseif opts.prompt:match ".*Session" or opts.kind == "mason.ui.language-filter" then
					local opt = {}
					if opts.prompt:match "^Delete" then
						opt = { initial_mode = "normal" }
					end
					return { telescope = require("telescope.themes").get_dropdown(opt) }
				end
			end,
		},
	},
}
