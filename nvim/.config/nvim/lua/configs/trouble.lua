require('telescope.actions')
local trouble = require('trouble')
trouble.setup()

require('which-key').register({
	['<leader>t'] = {trouble.toggle, 'Trouble'},
})

