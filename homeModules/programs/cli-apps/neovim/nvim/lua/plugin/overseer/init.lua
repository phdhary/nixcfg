return {
	"stevearc/overseer.nvim",
	keys = {
		{ "<leader>tt", "<CMD>OverseerToggle<CR>" },
		{ "<leader>tr", "<CMD>OverseerRun<CR>" },
		{ "<leader>ta", "<CMD>OverseerTaskAction<CR>" },
	},
	config = function()
		local overseer = require "overseer"
		overseer.setup {
			task_list = { bindings = { ["q"] = vim.cmd.OverseerClose } },
			form = { border = require("user.config").border },
			task_win = { border = require("user.config").border },
			confirm = { border = require("user.config").border },
		}
		overseer.register_template {
			name = "Live Server",
			desc = "serve index.html",
			condition = {
				callback = function()
					return vim.fs.dirname(vim.fs.find({ "index.html" }, { upward = true })[1])
				end,
			},
			builder = function()
				return { cmd = { "live-server", "." } }
			end,
		}
	end,
}
