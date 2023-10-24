--[[ local spec = {
	"simrat39/rust-tools.nvim",
	ft = "rust",
	dependencies = "nvim-lspconfig",
}

---@class rust_tools_opts
spec.opts = {
	tools = {
		on_initialized = nil,
		reload_workspace_from_cargo_toml = true,
		inlay_hints = {
			auto = true,
			only_current_line = false,
			show_parameter_hints = true,
			parameter_hints_prefix = "<- ",
			other_hints_prefix = "=> ",
			max_len_align = false,
			max_len_align_padding = 1,
			right_align = false,
			right_align_padding = 7,
			highlight = "Comment",
		},
		hover_actions = {
			border = {
				{ require("user.config").border[1], "FloatBorder" },
				{ require("user.config").border[2], "FloatBorder" },
				{ require("user.config").border[3], "FloatBorder" },
				{ require("user.config").border[4], "FloatBorder" },
				{ require("user.config").border[5], "FloatBorder" },
				{ require("user.config").border[6], "FloatBorder" },
				{ require("user.config").border[7], "FloatBorder" },
				{ require("user.config").border[8], "FloatBorder" },
			},
			max_width = nil,
			max_height = nil,
			auto_focus = false,
		},
	},
}

---@param opts rust_tools_opts
function spec.config(_, opts)
	local rust_tools = require "rust-tools"
	local extension_path = require("user.utils").mason_packages_path .. "/codelldb/extension/"
	local codelldb_path = extension_path .. "adapter/codelldb"
	local liblldb_path = extension_path .. "lldb/lib/liblldb.so" -- MacOS: This may be .dylib
	opts.tools.executor = require("rust-tools.executors").termopen
	opts.server = {
		standalone = true,
		on_attach = function(client, bufnr)
			require("user.lang_utils").on_attach(client, bufnr)
			vim.keymap.set("n", "K", rust_tools.hover_actions.hover_actions, { buffer = bufnr })
			vim.keymap.set("n", "<leader>ca", rust_tools.code_action_group.code_action_group, { buffer = bufnr })
		end,
	}
	opts.dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	}
	rust_tools.setup(opts)
end

return spec ]]

return {}

