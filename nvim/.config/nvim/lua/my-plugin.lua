local M = {}

local ts_utils = require("nvim-treesitter.ts_utils")

local ts = require('nvim-treesitter')
local parsers = require('nvim-treesitter.parsers')

-- Define a function to select all matching regex in the
-- current buffer
M.SelectMatchingRegex = function(pattern)
  local bufnr = vim.fn.bufnr()
  local query = vim.fn.getreg("/")   -- Get the last search pattern (regex) from the search register

  -- Check if a pattern is provided; otherwise, use the last search pattern
  pattern = pattern or query

  -- Iterate through TreeSitter queries to find matching text
  local root = vim.treesitter.get_parser(bufnr, vim.bo.filetype):parse()[1]:root()
  for match in vim.treesitter.query(bufnr, pattern):iter_matches(root, bufnr, 0, -1) do
    local start_row, start_col, end_row, end_col = match.node:range()
    vim.fn.setpos(".", { bufnr, start_row + 1, start_col + 1, 0 })
    vim.cmd("normal! v")
    vim.fn.setpos(".", { bufnr, end_row + 1, end_col + 1, 0 })
  end
end

local a = M.SelectMatchingRegex('^//.*^?')

M.findTwoSlashes = function()

end

M.setup = function()

end

return M
