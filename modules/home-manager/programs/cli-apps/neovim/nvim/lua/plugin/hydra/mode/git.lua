return function(invoke_on_body)
	local Hydra, gitsigns = require "hydra", require "gitsigns"
	local function go_to_hunk(next_or_prev)
    -- stylua: ignore
		if vim.wo.diff then return next_or_prev == "next" and "]c" or "[c" end
		vim.schedule(function()
			if next_or_prev == "next" then
				gitsigns.next_hunk()
			else
				gitsigns.prev_hunk()
			end
		end)
		return "<Ignore>"
	end
	local function stage_hunk()
		local mode = vim.api.nvim_get_mode().mode:sub(1, 1)
		if mode == "V" then
			local colon = vim.api.nvim_replace_termcodes(":", true, true, true)
			vim.api.nvim_feedkeys(colon, "x", false)
			vim.cmd "'<,'>Gitsigns stage_hunk"
		else
			vim.cmd "Gitsigns stage_hunk"
		end
	end
	local opts = {
		name = "",
		hint = [[_<C-e>_  _J_:next-hunk  _K_:prev-hunk  _S_tage-buffer  _s_tage-hunk  _u_ndo-stage  _p_review  toggle-_d_eleted  _b_lame  _B_lame-full  _R_eset-hunk]],
		config = {
			color = "pink",
			-- hint = { type = "cmdline", show_name = false },
			hint = { type = "window", position = "top", show_name = false },
      -- stylua: ignore
      on_key = function() vim.wait(50) end,
      -- stylua: ignore
			on_exit = function() gitsigns.toggle_deleted(false) end,
		},
		mode = { "n", "x" },
		heads = {
      -- stylua: ignore
			{ "J", function() return go_to_hunk "next" end, { expr = true } },
      -- stylua: ignore
			{ "K", function() return go_to_hunk "prev" end, { expr = true } },
			{ "s", stage_hunk },
			{ "u", gitsigns.undo_stage_hunk },
			{ "S", gitsigns.stage_buffer },
			{ "p", gitsigns.preview_hunk },
			{ "d", gitsigns.toggle_deleted, { nowait = true } },
			{ "b", gitsigns.blame_line },
      -- stylua: ignore
      { "B", function() gitsigns.blame_line { full = true } end  },
			{ "R", gitsigns.reset_hunk },
			{ "<C-e>", nil, { exit = true, nowait = true } },
		},
	}

	opts.config.hint = false
	if invoke_on_body then
		opts.body = "<leader>gm"
		opts.config.hint = false
		opts.config.invoke_on_body = true
		opts.config.on_enter = function()
			gitsigns.toggle_linehl(true)
		end
		opts.config.on_exit = function()
			gitsigns.toggle_linehl(false)
			gitsigns.toggle_deleted(false)
		end
	end

	return Hydra(opts)
end
