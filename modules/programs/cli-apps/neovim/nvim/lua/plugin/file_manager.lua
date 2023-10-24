vim.g.neo_tree_remove_legacy_commands = true

return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		keys = { { "<leader>e", "<CMD>Neotree reveal toggle<CR>" } },
		dependencies = {
			"MunifTanjim/nui.nvim",
			{
				"s1n7ax/nvim-window-picker",
				version = "v1.*",
				config = function()
					require("window-picker").setup {
						autoselect_one = true,
						include_current = false,
						fg_color = "white",
						other_win_hl_color = "black",
						filter_rules = {
							bo = {
								filetype = { "neo-tree", "neo-tree-popup", "notify" },
								buftype = { "terminal", "quickfix" },
							},
						},
					}
				end,
			},
		},
		opts = {
			hide_root_node = true,
			use_popups_for_input = false, -- If false, inputs will use vim.ui.input() instead of custom floats.
			default_component_configs = {
				modified = { symbol = " " },
				name = { use_git_status_colors = false },
				indent = {
					with_expanders = true,
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				git_status = {
					symbols = {
						-- Change type
						added = "A",
						deleted = "D",
						modified = "",
						renamed = "R",
						-- Status type
						untracked = "U",
						ignored = "I",
						unstaged = "M",
						staged = "M",
						conflict = "",
					},
				},
			},
			filesystem = {
				filtered_items = { visible = true },
				hijack_netrw_behavior = "disabled", -- open_default open_current disabled
			},
			window = {
				position = "left", -- current,float,right,left
				auto_expand_width = true,
				width = 0,
				mappings = {
					["<Tab>"] = function(state)
						local node = state.tree:get_node()
						if require("neo-tree.utils").is_expandable(node) then
							state.commands["toggle_node"](state)
						else
							state.commands["open"](state)
							vim.cmd "Neotree focus"
						end
					end,
					["o"] = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						-- Linux: open file in default application
						vim.api.nvim_command(string.format("silent !xdg-open '%s'", path))
					end,
					["i"] = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						vim.api.nvim_input(": " .. path .. "<Home>")
					end,
					["<Space>"] = "none",
					["s"] = "none",
					["S"] = "none",
					["H"] = "none",
					["<C-h>"] = "toggle_hidden",
					["<C-x>"] = "open_split",
					["<C-v>"] = "open_vsplit",
					["<C-t>"] = "open_tabnew",
				},
			},
		},
	},
	{
		"stevearc/oil.nvim",
		lazy = false,
		keys = {
			{ "<leader>o", vim.cmd.Oil },
			{ "<leader>O", ":lua require('oil').open(vim.fn.getcwd())<CR>", silent = true },
		},
		opts = {
			columns = {
				{ "type", icons = { file = ".", directory = "d", link = "l" } },
				{ "permissions", highlight = "Special" },
				{ "size", highlight = "String" },
				{ "mtime", format = "%d %b %H:%M", highlight = "Statement" },
				{ "icon", directory = "" },
			},
			skip_confirm_for_simple_edits = true,
			keymaps = {
				["`"] = "actions.cd",
				["~"] = "actions.tcd",
				["-"] = "actions.parent",
				["R"] = "actions.refresh",
				["_"] = "actions.open_cwd",
				["<CR>"] = "actions.select",
				["<S-l>"] = "actions.select",
				["<S-h>"] = "actions.parent",
				["g?"] = "actions.show_help",
				["<C-v>"] = "actions.select_vsplit",
				["<C-x>"] = "actions.select_split",
				["<C-t>"] = "actions.select_tab",
				["<C-f>"] = "actions.preview_scroll_down",
				["<C-b>"] = "actions.preview_scroll_up",
				["<A-t>"] = "actions.open_terminal",
				["<C-.>"] = "actions.open_cmdline",
				["<Tab>"] = "actions.preview",
				["<C-e>"] = "actions.close",
				["<C-h>"] = "actions.toggle_hidden",
			},
			use_default_keymaps = false, -- Set to false to disable all of the above keymaps
			view_options = { show_hidden = true },
			float = { -- Configuration for the floating window in oil.open_float
				padding = 0, -- Padding around the floating window
				max_width = 0,
				max_height = 0,
				border = require("user.config").border,
				win_options = { winblend = 0 },
			},
			preview = { -- Configuration for the actions floating preview window
				max_width = 0.9,
				min_width = { 40, 0.4 }, -- means "the greater of 40 columns or 40% of total"
				width = nil, -- optionally define an integer/float for the exact width of the preview window
				max_height = 0.9, -- max_height = {80, 0.9} means "the lesser of 80 columns or 90% of total"
				min_height = { 5, 0.1 }, -- min_height = {5, 0.1} means "the greater of 5 columns or 10% of total"
				height = nil, -- optionally define an integer/float for the exact height of the preview window
				border = require("user.config").border,
				win_options = { winblend = 0 },
			},
			progress = { -- Configuration for the floating progress window
				max_width = 0.9,
				min_width = { 40, 0.4 },
				width = nil,
				max_height = { 10, 0.9 },
				min_height = { 5, 0.1 },
				height = nil,
				border = require("user.config").border,
				minimized_border = "none",
				win_options = { winblend = 0 },
			},
		},
	},
}
