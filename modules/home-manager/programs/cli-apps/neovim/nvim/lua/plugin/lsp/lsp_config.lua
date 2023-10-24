local spec = {
	"neovim/nvim-lspconfig",
	event = "BufRead",
	keys = { { "<leader>li", vim.cmd.LspInfo } },
	dependencies = {
		"b0o/schemastore.nvim",
		{
			-- "williamboman/mason.nvim",
			-- keys = { { "<leader>ma", vim.cmd.Mason } },
			-- opts = {
			-- 	ui = {
			-- 		width = 1,
			-- 		height = 1,
			-- 		border = "none",
			-- 		keymaps = { toggle_package_expand = "<Tab>" },
			-- 	},
			-- },
		},
		{
			-- "williamboman/mason-lspconfig.nvim",
			-- opts = { ensure_installed = require("user.lang_utils").ensure_installed.lsp },
			-- dependencies = "mason.nvim",
		},
		{
			"folke/neodev.nvim",
			opts = {
				library = {
					plugins = false, -- enable this to make lua lsp load plugins
					-- plugins = { "neovim-session-manager" },
				},
			},
		},
		"efmls-configs-nvim",
	},
}

function spec.config()
	local lspconfig, lang_utils = require "lspconfig", require "user.lang_utils"
	require("lspconfig.ui.windows").default_options.border = require("user.config").border

	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	local lsps = lang_utils.ensure_installed.lsp
	-- local non_mason_list = { "nixd" }
	-- lsps = vim.tbl_extend("force", lsps, non_mason_list)

	for _, lsp in ipairs(lsps) do
		if lsp:match "@" then
			local _, final = lsp:find "@"
			lsp = lsp:sub(1, final - 1)
		end
		local opts = { capabilities = capabilities, on_attach = lang_utils.on_attach }
		if lsp == "lua_ls" then
			opts.settings = {
				Lua = {
					completion = { callSnippet = "Replace" },
					format = { enable = false },
					workspace = { checkThirdParty = false },
					hint = { enable = true },
				},
			}
		elseif lsp == "jsonls" then
			opts.cmd = { "json-languageserver", "--stdio" }
			opts.settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			}
		elseif lsp == "cssls" then
			opts.cmd = { "css-languageserver", "--stdio" }
			opts.settings = { css = { lint = { unknownAtRules = "ignore" } } }
		elseif lsp == "html" then
			opts.cmd = { "html-languageserver", "--stdio" }
		elseif lsp == "tailwindcss" then
			opts.root_dir = function(fname)
				local root_pattern =
					lspconfig.util.root_pattern("tailwind.config.cjs", "tailwind.config.js", "postcss.config.js")
				return root_pattern(fname)
			end
		elseif lsp == "marksman" then
			opts.filetypes = { "markdown", "vimwiki" }
		elseif lsp == "ansiblels" then
			opts.single_file_support = false
			opts.filetypes = { "yaml", "yaml.ansible" }
			opts.root_dir = function(fname)
				local root_pattern = lspconfig.util.root_pattern "ansible.cfg"
				return root_pattern(fname)
			end
		elseif lsp == "yamlls" then
			opts.settings = { redhat = { telemetry = { enabled = false } } }
		elseif lsp == "nil_ls" then
			opts.settings = {
				["nil"] = {
					formatting = { command = { "nixfmt" } },
					-- nix = { flake = { autoEvalInputs = true } },
				},
			}
		elseif lsp == "nixd" then
			opts.settings = {
				["nixd"] = {
					formatting = { command = "alejandra" },
				},
			}
		elseif lsp == "efm" then
			opts.filetypes = require("plugin.lsp.efm").filetypes
			opts.settings = require("plugin.lsp.efm").settings
			opts.init_options = require("plugin.lsp.efm").init_options
		end
		lspconfig[lsp].setup(opts)
	end
end

return spec
