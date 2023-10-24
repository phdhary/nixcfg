return {
	"nvim-neotest/neotest",
	keys = {
		{ "<leader>nts", "<CMD>Neotest summary<CR>" },
		{ "<leader>ntr", "<CMD>Neotest run<CR>" },
		{ "<leader>nto", "<CMD>Neotest output-panel<CR>" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		"haydenmeade/neotest-jest",
	},
	config = function()
		require("neotest").setup {
			summary = {
				mappings = {
					expand = { "<Tab>", "<CR>", "<2-LeftMouse>" },
				},
			},
			adapters = {
				require "neotest-jest" {
					-- jestCommand = "npm test -- --watch",
					jestCommand = "npm test --",
					jestConfigFile = "custom.jest.config.ts",
					env = { CI = true },
					cwd = function(_)
						return vim.fn.getcwd()
					end,
				},
			},
		}
	end,
}
