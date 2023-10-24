return {
	"rebelot/heirline.nvim",
	event = "VimEnter",
	dependencies = "nvim-config-lib",
	config = function()
		require("nvim-config-lib").heirline.setup {
			nerd_fonts = false,
		}
	end,
}
