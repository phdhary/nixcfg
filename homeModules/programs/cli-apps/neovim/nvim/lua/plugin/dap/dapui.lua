local spec = {
	"rcarriga/nvim-dap-ui",
	version = "v3.*",
	lazy = true,
	keys = { "<leader>db" },
}

---@class dapui_opts
spec.opts = {
	icons = { expanded = "", collapsed = "", current_frame = "" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>", "<Tab>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	-- Use this to override mappings for specific elements
	element_mappings = {
		-- Example:
		-- stacks = {
		--   open = "<CR>",
		--   expand = "o",
		-- }
	},
	expand_lines = vim.fn.has "nvim-0.7" == 1,
	layouts = {
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				{ id = "scopes", size = 0.25 },
				"breakpoints",
				"stacks",
				"watches",
			},
			size = 40, -- 40 columns
			position = "left",
		},
	},
	controls = { enabled = false },
	windows = { indent = 1 },
	render = {
		max_type_length = nil, -- Can be integer or nil.
		max_value_lines = 100, -- Can be integer or nil.
	},
}

local function setup_hydra_mode()
	local dap = require "dap"
	local Hydra, cmd = require "hydra", require("hydra.keymap-util").cmd
	Hydra {
		hint = [[
         
 _c_ _p_ _K_ _J_ _H_ _L_ _R_ _x_

toggle _r_epl
toggle _u_i
_t_oggle breakpoint
clear breakpoin_T_s
_gh_over
_<Up>_ w/o step
_<Down>_ w/o step

_o_pen commands
_<C-e>_exit]],
		config = {
			invoke_on_body = true,
			color = "pink",
			hint = {
				show_name = false,
				type = "window",
				position = "middle-right",
				border = require("user.config").border,
			},
		},
		mode = "n",
		body = "<leader>db",
		heads = {
			{ "c", dap.continue },
			{ "p", dap.pause },
			{ "K", dap.step_back },
			{ "J", dap.step_over },
			{ "H", dap.step_out },
			{ "L", dap.step_into },
      -- stylua: ignore
			{ "R", function() pcall(dap.restart) end },
			{ "x", dap.terminate },
			{ "r", dap.repl.toggle },
			{ "t", dap.toggle_breakpoint },
			{ "T", dap.clear_breakpoints },
			{ "o", cmd "Telescope dap commands", { exit = true } },
			{ "<C-e>", nil, { exit = true, nowait = true } },
			{ "gh", require("dap.ui.widgets").hover },
			{ "<Up>", dap.up },
			{ "<Down>", dap.down },
			{ "u", require("dapui").toggle },
		},
	}
end

---@param opts dapui_opts
function spec.config(_, opts)
	local dapui, sign = require "dapui", vim.fn.sign_define
	sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
	sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
	sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
	dapui.setup(opts)
	setup_hydra_mode()
end

return spec
