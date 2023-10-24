return {
	"Vigemus/iron.nvim",
	keys = {
		{ "<leader>rr", "<cmd>IronRepl<cr>" },
		{ "<space>rt", "<cmd>IronRestart<cr>" },
	},
	config = function()
		local iron = require "iron.core"

		iron.setup {
			config = {
				highlight_last = "",
				-- Whether a repl should be discarded or not
				scratch_repl = true,
				-- Your repl definitions come here
				repl_definition = {
					sh = {
						-- Can be a table or a function that
						-- returns a table (see below)
						command = { "zsh" },
					},
				},
				-- How the repl window will be displayed
				-- See below for more information
				repl_open_cmd = require("iron.view").split "40%",
			},
			-- Iron doesn't set keymaps by default anymore.
			-- You can set them here or manually add keymaps to the functions in iron.core
			keymaps = {
				send_motion = "<space>rsc",
				visual_send = "<space>rsc",
				send_file = "<space>rsf",
				send_line = "<space>rsl",
				send_until_cursor = "<space>rsu",
				send_mark = "<space>rsm",
				mark_motion = "<space>rmc",
				mark_visual = "<space>rmc",
				remove_mark = "<space>rmd",
				cr = "<space>rs<cr>",
				interrupt = "<space>rs<space>",
				exit = "<space>rsq",
				clear = "<space>rcl",
			},
			-- If the highlight is on, you can change how it looks
			-- For the available options, check nvim_set_hl
			-- highlight = {
			-- 	italic = true,
			-- },
			ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
		}
	end,
}
