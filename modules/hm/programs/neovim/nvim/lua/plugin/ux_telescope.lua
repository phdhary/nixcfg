local function layout_flex(another_settings)
	return vim.tbl_extend("force", {
		layout_strategy = "flex",
		layout_config = { horizontal = { preview_width = 0.5 } },
	}, another_settings or {})
end

local spec = {
	"nvim-telescope/telescope.nvim",
	version = "0.1.3",
	cmd = "Telescope",
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
		{
			"luckasRanarison/nvim-devdocs",
			keys = {
				{ "<leader>do", ":DevdocsOpen " },
				{ "<leader>dd", "<CMD>DevdocsOpenCurrent<CR>" },
			},
			opts = { telescope = layout_flex() },
		},
	},
}

local colorscheme = function()
	local action_state = require "telescope.actions.state"
	local actions = require "telescope.actions"
	local conf = require("telescope.config").values
	local finders = require "telescope.finders"
	local pickers = require "telescope.pickers"
	local themes = require "telescope.themes"
	local utils = require "telescope.utils"
	local before_color = vim.api.nvim_exec2("colorscheme", { output = true })
	local colors = { before_color.output }
	colors = vim.list_extend(
		colors,
		vim.tbl_filter(function(color)
			return color ~= before_color
		end, vim.fn.getcompletion("", "color"))
	)

	local picker = pickers.new(themes.get_dropdown(), {
		prompt_title = "Change Colorscheme",
		finder = finders.new_table {
			results = colors,
		},
		sorter = conf.generic_sorter(),
		attach_mappings = function(prompt_bufnr)
			actions.select_default:replace(function()
				local selection = action_state.get_selected_entry()
				if selection == nil then
					utils.__warn_no_selection "builtin.colorscheme"
					return
				end

				actions.close(prompt_bufnr)
				require("user.config").colorscheme = selection.value
				vim.cmd("colorscheme " .. selection.value)
			end)

			return true
		end,
	})

	picker:find()
end

local function fd_or_git()
	local is_git_dir = vim.fn.system("git rev-parse --is-inside-work-tree"):match "true"
	if is_git_dir == nil then
		return "<CMD>Telescope fd<CR>"
	end
	return "<CMD>Telescope git_files<CR>"
end

spec.keys = {
	{ "<C-p>", fd_or_git, expr = true },
	{ "<leader>ff", fd_or_git, expr = true },
	{ "<leader>fw", "<CMD>Telescope grep_string<CR>" },
	{ "<leader>fo", "<CMD>Telescope oldfiles<CR>" },
	{ "<leader>fr", "<CMD>Telescope registers<CR>" },
	{ "<leader>/", "<CMD>Telescope live_grep<CR>" },
	{ "<leader>:", "<CMD>Telescope command_history<CR>" },
	{ "<leader>sc", colorscheme },
	-- { "<leader>sc", "<CMD>Telescope colorscheme<CR>" },
	{ "<leader>sh", "<CMD>Telescope help_tags<CR>" },
	{ "<leader>sb", "<CMD>Telescope buffers<CR>" },
	{ "<leader>sk", "<CMD>Telescope keymaps<CR>" },
	{ "<leader>gsl", "<CMD>Telescope git_stash<CR>" },
	{ "<leader>qh", "<CMD>Telescope quickfixhistory<CR>" },
	{ "<leader>pr", "<CMD>Telescope diagnostics<CR>" },
}

---@class telescope_opts
spec.opts = {
	defaults = {
		selection_caret = " ",
		prompt_prefix = " ",
		mappings = {
			i = {
				["<C-o>"] = "select_default",
				["<C-j>"] = "move_selection_next",
				["<C-k>"] = "move_selection_previous",
			},
			n = {
				o = "select_default",
				q = "close",
			},
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--trim",
		},
	},
	pickers = {
		colorscheme = { theme = "dropdown" },
		command_history = { theme = "ivy", results_title = false, layout_config = { height = 0.3 } },
		live_grep = layout_flex(),
		help_tags = layout_flex(),
		man_pages = layout_flex(),
		builtin = layout_flex(),
		fd = layout_flex { follow = true },
		lsp_references = layout_flex { initial_mode = "normal", show_line = false },
		lsp_implementations = layout_flex { initial_mode = "normal" },
		lsp_definitions = layout_flex { initial_mode = "normal" },
		lsp_type_definitions = layout_flex { initial_mode = "normal" },
		diagnostics = layout_flex { initial_mode = "normal" },
		git_files = layout_flex { show_untracked = true, use_git_root = false },
		grep_string = layout_flex { initial_mode = "normal" },
		git_status = layout_flex { initial_mode = "normal" },
		git_stash = layout_flex { initial_mode = "normal" },
		git_branches = layout_flex { initial_mode = "normal" },
		git_commits = layout_flex { initial_mode = "normal" },
		oldfiles = layout_flex { initial_mode = "normal", cwd_only = true },
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
}

---@param opts telescope_opts
function spec.config(_, opts)
	local telescope, actions = require "telescope", require "telescope.actions"
	opts.pickers.buffers = layout_flex {
		initial_mode = "normal",
		mappings = { n = { ["dd"] = actions.delete_buffer } },
	}
	opts.defaults.mappings.i["<C-l>"] = actions.smart_send_to_loclist + actions.open_loclist
	opts.defaults.mappings.n["<C-l>"] = actions.smart_send_to_loclist + actions.open_loclist
	telescope.setup(opts)
	telescope.load_extension "fzf"
end

return spec
