local spec = {
	"creativenull/efmls-configs-nvim",
	lazy = true,
	version = "v1.x.x", -- version is optional, but recommended
}

spec.config = function()
	local beautysh = require "efmls-configs.formatters.beautysh"
	local black = require "efmls-configs.formatters.black"
	local eslint_d = require "efmls-configs.linters.eslint_d"
	local fixjson = require "efmls-configs.formatters.fixjson"
	local prettier_d = require "efmls-configs.formatters.prettier_d"
	local shellharden = require "efmls-configs.formatters.shellharden"
	local stylelint = require "efmls-configs.linters.stylelint"
	local stylua = require "efmls-configs.formatters.stylua"
	-- local yq = { formatCommand = "yq -y ." }
	local languages = {
		lua = { stylua },
		json = { fixjson },
		python = { black },
		sh = { shellharden },
		markdown = { prettier_d },
		css = { prettier_d, stylelint },
		javascript = { eslint_d, prettier_d },
		typescript = { eslint_d, prettier_d },
		zsh = { beautysh },
		-- yaml = { yq },
	}

	spec.filetypes = vim.tbl_keys(languages)
	spec.settings = {
		rootMarkers = { ".git/" },
		languages = languages,
	}
	spec.init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	}
end

return spec
