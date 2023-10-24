local spec = {
	"ThePrimeagen/harpoon",
	opts = {
		menu = {
			-- width = vim.api.nvim_win_get_width(0) - 4,
			width = 60,
			borderchars = {
				require("user.config").border[2],
				require("user.config").border[4],
				require("user.config").border[6],
				require("user.config").border[8],
				require("user.config").border[1],
				require("user.config").border[3],
				require("user.config").border[5],
				require("user.config").border[7],
			},
		},
	},
}

-- stylua: ignore
spec.keys = {
  { "<leader>h", function() require("harpoon.ui").toggle_quick_menu() end },
  { "<leader>a", function() require("harpoon.mark").add_file() end },
}

for i = 1, 9 do
  -- stylua: ignore
	table.insert(spec.keys, {
    "<leader>".. i, function() require("harpoon.ui").nav_file(i) end,
	})
end

return spec
