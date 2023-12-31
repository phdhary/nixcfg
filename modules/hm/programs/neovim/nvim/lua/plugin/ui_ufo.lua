local spec = {
	"kevinhwang91/nvim-ufo",
	event = "BufRead",
	dependencies = "kevinhwang91/promise-async",
}

local handler = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = ("  %d "):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, "MoreMsg" })
	return newVirtText
end

-- stylua: ignore
spec.keys = {
	{ "zR", function() pcall(require("ufo").openAllFold) end },
	{ "zM", function() pcall(require("ufo").seAllFold) end },
}

spec.opts = {
	open_fold_hl_timeout = 0,
	fold_virt_text_handler = handler,
}

function spec.config(_, opts)
	vim.opt.foldcolumn = "0"
	vim.opt.foldenable = true
	vim.opt.foldlevel = 99
	vim.opt.foldlevelstart = 99
	require("ufo").setup(opts)
end

return spec
