require('which-key').register({
	['<leader>u'] = { require('telescope').extensions.undo.undo, 'Undotree Toggle' },
	['<leader>fu'] = { require('telescope').extensions.undo.undo, 'Find Undo History' }
})
