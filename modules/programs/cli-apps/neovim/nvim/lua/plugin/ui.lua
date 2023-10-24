return {
	{ "fladson/vim-kitty", ft = "kitty" },
	{
		"ziontee113/icon-picker.nvim",
		opts = { disable_legacy_commands = true },
		keys = { { "<leader>ic", vim.cmd.IconPickerNormal } },
	},
	{
		"vigoux/notifier.nvim",
		event = "VimEnter",
		config = function()
			require("notifier").setup()
			local vim_notify = vim.notify
			---@diagnostic disable-next-line: duplicate-set-field
			vim.notify = function(msg, level, opts)
				if msg == "No information available" then
					return
				end
				return vim_notify(msg, level, opts)
			end
		end,
	},
	{
		"mbbill/undotree",
		keys = { { "<leader>u", vim.cmd.UndotreeToggle } },
		config = function()
			vim.g.undotree_DiffAutoOpen = 0
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.g.undotree_ShortIndicators = 1
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		event = "BufRead",
		opts = {
			filetypes = { "*", "!mason", "!lazy" },
			user_default_options = {
				mode = "background", -- virtualtext {fore|back}ground
				tailwind = true, -- Enable tailwind colors
				virtualtext = "■",
			},
		},
	},
	{
		"iamcco/markdown-preview.nvim", -- view markdown files in browser
		version = "*",
		ft = "markdown",
		build = "cd app && ./install.sh",
		keys = { { "<leader>mp", vim.cmd.MarkdownPreviewToggle } },
		init = function()
			vim.cmd [[ function OpenMarkdownPreview (url)
        execute "silent ! firefox-nightly --new-window " . a:url
      endfunction]]
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		version = "v2.*",
		event = "BufRead",
		enabled = true,
		keys = { { "<leader>ib", vim.cmd.IndentBlanklineToggle } },
		opts = {
			enabled = false,
			use_treesitter = true,
			show_current_context = true,
			filetype_exclude = {
				"",
				"fugitive",
				"git",
				"help",
				"lazy",
				"lspinfo",
				"markdown",
				"mason",
				"TelescopePrompt",
				"TelescopeResults",
				"terminal",
				"OverseerForm",
			},
			-- char = "┆",
			-- context_char = "┆",
			-- show_current_context_start = true,
		},
	},
}
