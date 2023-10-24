local spec = {
	"mfussenegger/nvim-dap",
	-- event = "BufRead",
  lazy = true,
	dependencies = {
		"nvim-dap-ui",
		-- { "jay-babu/mason-nvim-dap.nvim", dependencies = "mason" },
	},
}

function spec.config()
	require "plugin.dap.adapters.firefox"
	require "plugin.dap.adapters.chrome"
	require "plugin.dap.adapters.php"
	require "plugin.dap.adapters.node"

	-- setup mason_nvim_dap
	-- local mason_nvim_dap = require "mason-nvim-dap"
	-- mason_nvim_dap.setup {
	-- 	automatic_setup = true,
	-- }
	-- mason_nvim_dap.setup_handlers()
end

return spec
