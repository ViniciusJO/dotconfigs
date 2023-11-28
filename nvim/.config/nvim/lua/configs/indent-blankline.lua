-- require('indent_blankline').setup({
--   char = '┊',
--   show_trailing_blankline_indent = false,
-- })
require('ibl').setup({
	debounce = 100,
	indent = { char = "┊" },
	whitespace = { highlight = { "Whitespace", "NonText" } },
	scope = { exclude = { language = { "lua" } } },
})
