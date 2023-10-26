local spec = {
	"anuvyklack/hydra.nvim",
	dependencies = "mrjones2014/smart-splits.nvim",
}

spec.keys = {
	"z",
	"<C-w>",
	"<leader>gm",
}

function spec.config()
	local Hydra = require "hydra"
	local config = { hint = false, timeout = true }

	Hydra {
    -- stylua: ignore
    config = vim.tbl_extend("force", config, { on_exit = function() pcall(vim.cmd.IndentBlanklineRefresh) end }),
		mode = "n",
		body = "z",
		heads = {
			{ "h", "10zh", { desc = "←" } },
			{ "l", "10zl", { desc = "→" } },
			{ "H", "zH", { desc = "half screen ←" } },
			{ "L", "zL", { desc = "half screen →" } },
		},
	}

	Hydra {
		config = config,
		mode = "n",
		body = "<C-w>",
		heads = {
			{ "<", "8<C-w><", { desc = "width +" } },
			{ ">", "8<C-W>>", { desc = "width -" } },
			{ "_", "2<C-w>-", { desc = "height -" } },
			{ "+", "2<C-W>+", { desc = "height +" } },
			{ "H", "<C-w>H", { desc = "move ←" } },
			{ "J", "<C-w>J", { desc = "move ↓" } },
			{ "K", "<C-w>K", { desc = "move ↑" } },
			{ "L", "<C-w>L", { desc = "move →" } },
			{ "s", "<C-w>s", { desc = "split horizontal" } },
			{ "v", "<C-w>v", { desc = "split vertical" } },
			{ "x", "<C-w>x", { desc = "rotate" } },
			{ "r", "<C-w>r", { desc = "rotate" } },
			{ "R", "<C-w>R", { desc = "rotate" } },
			{ "j", require("smart-splits").resize_down, { desc = "resize ↓" } },
			{ "k", require("smart-splits").resize_up, { desc = "resize ↑" } },
      -- stylua: ignore
      { "h", function() require("smart-splits").resize_left(8) end, { desc = "resize ←" } },
      -- stylua: ignore
      { "l", function() require("smart-splits").resize_right(8) end, { desc = "resize →" } },
		},
	}

	require "plugin.hydra.mode.git"(true)
end

return spec
