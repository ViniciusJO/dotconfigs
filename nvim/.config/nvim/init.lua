vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--require 'configs.lazy'
require 'options'
require 'aucmd'
-- require 'plugins'
require 'plugins'
--require 'configs'
require 'keymaps'
require 'commands'
require 'colorscheme'
require 'tui'
-- require 'nvim-llama'.setup()
--require('my-plugin')

--[[
local pattern = '\'.*\''
local bufnr = vim.fn.bufnr()
local query = vim.fn.getreg("/") -- Get the last search pattern (regex) from the search register
local root = vim.treesitter.get_parser(bufnr, vim.bo.filetype):parse()[1]:root()
for match in vim.treesitter.query(bufnr, pattern):iter_matches(root, bufnr, 0, -1) do
	print(match.node:range())
	local start_row, start_col, end_row, end_col = match.node:range()
	vim.fn.setpos(".", { bufnr, start_row + 1, start_col + 1, 0 })
	vim.cmd("normal! v")
	vim.fn.setpos(".", { bufnr, end_row + 1, end_col + 1, 0 })
end
--]]
--
