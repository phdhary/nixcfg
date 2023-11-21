local M = {}

function M.on_attach(client, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set("n", "<leader>ra", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	vim.keymap.set("n", "gR", "<CMD>Telescope lsp_references<CR>", opts)
	vim.keymap.set("n", "gi", "<CMD>Telescope lsp_implementations<CR>", opts)
	vim.keymap.set("n", "gd", "<CMD>Telescope lsp_definitions<CR>", opts)
	vim.keymap.set("n", "<leader>D", "<CMD>Telescope lsp_type_definitions<CR>", opts)
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set({ "n", "v" }, "<leader>fm", vim.lsp.buf.format, opts)
	vim.lsp.handlers["textDocument/hover"] =
		vim.lsp.with(vim.lsp.handlers.hover, { border = require("user.config").border })
	if vim.version().api_prerelease and client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint(0, true)
	end
  client.server_capabilities.semanticTokensProvider = nil
end

M.ensure_installed = {
	lsp = {
		"ansiblels",
		"astro",
		"bashls",
		-- "ccls",
		"cssls",
		"dockerls",
		"efm",
		"emmet_ls",
		"gopls",
		"html",
		"intelephense",
		"jsonls",
		"lua_ls",
		"marksman",
		"nil_ls",
		-- "nixd",
		"pyright",
		"svelte",
		"tailwindcss",
		"taplo",
		"texlab",
		"vimls",
		"vuels",
		-- "yamlls",
		-- "fennel_language_server",
		-- "lua_ls@3.6.19",
		-- "rust_analyzer", -- handled by rust-tools
		-- "tsserver", -- handled by typescript plugin
	},
	treesitter = {
		"astro",
		"bash",
		"bibtex",
		-- "comment", -- forbidden one
		"css",
		"dart",
		"dockerfile",
		"fennel",
		"git_rebase",
		"gitattributes",
		"gitcommit",
		"gitignore",
		"go",
		"html",
		"ini",
		"javascript",
		"jsdoc",
		"json",
		"json5",
		"jsonc",
		"latex",
		"lua",
		"make",
		"markdown",
		"markdown_inline",
		"mermaid",
		"org",
		"php",
		"phpdoc",
		"python",
		"rasi",
		"regex",
		"rust",
		"scss",
		"svelte",
		"todotxt",
		"toml",
		"tsx",
		"typescript",
		"vim",
		"vimdoc",
		"vue",
		-- "yaml",
		"yuck",
	},
}

return M
