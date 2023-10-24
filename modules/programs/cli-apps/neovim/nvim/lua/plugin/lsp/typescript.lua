return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	ft = {
		"javascript",
		"javascriptreact",
		"javascript.jsx",
		"typescript",
		"typescriptreact",
		"typescript.tsx",
	},
	opts = {
		settings = {
			expose_as_code_action = { "fix_all", "add_missing_imports", "remove_unused" },
			tsserver_path = vim.env.HOME .. "/.local/share/pnpm/global/5/node_modules/typescript/bin/tsserver",
			complete_function_calls = true,
			-- tsserver_file_preferences = { disableSuggestions = true },
		},
		on_attach = function(client, bufnr)
			require("user.lang_utils").on_attach(client, bufnr)
			client.server_capabilities.document_formatting = false
		end,
	},
}
