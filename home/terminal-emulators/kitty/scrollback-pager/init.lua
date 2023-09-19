vim.cmd("set smartcase ignorecase noswapfile termguicolors")
vim.opt.clipboard = "unnamedplus"
vim.opt.scrollback = 100000
vim.opt.laststatus = 0
vim.opt.scrolloff = 5
vim.keymap.set("n", "i", "<nop>", {})
vim.keymap.set("n", "a", "<nop>", {})
vim.keymap.set("n", "o", "<nop>", {})
vim.keymap.set("n", "q", vim.cmd.quitall, {})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {})
vim.keymap.set("n", "<C-d>", "<C-d>zz", {})
vim.keymap.set("n", "u", "<C-u>", { remap = true })
vim.keymap.set("n", "d", "<C-d>", { remap = true })
vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch, {})
vim.api.nvim_set_hl(0, "Visual", { link = "DiffAdd" })
vim.cmd([[augroup General
  au!
  au TermEnter * stopinsert
  au TextYankPost * lua vim.highlight.on_yank()
  au VimEnter * silent exec 'write! /tmp/kitty_scrollback_buffer | te cat /tmp/kitty_scrollback_buffer -' | normal G
  au VimLeave * !rm -rf /tmp/kitty_scrollback_buffer
augroup END]])
