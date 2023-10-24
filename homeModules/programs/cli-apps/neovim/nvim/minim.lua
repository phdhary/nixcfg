vim.g.mapleader = " "
require "user.options"
require "user.utils"
require "user.autocmds"
require "user.mappings"
require "user.commands"
vim.keymap.set("n", ",e", ":e **/*<C-z><S-Tab>")
vim.keymap.set("n", ",f", ":e %:h/<C-z><S-Tab>")
