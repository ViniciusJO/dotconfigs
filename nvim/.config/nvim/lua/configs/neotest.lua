local neotest = require('neotest')
neotest.setup({
	adapters = {
		require("neotest-plenary"),
		require('neotest-vitest')
	}
})

require('which-key').register({
	['<leader>T'] = {
		name = 'Teste',
		r = {neotest.run.run(), 'Run nearest'},
		f = {neotest.run.run(vim.fn.expand('%')), 'Run file'	},
		d = {
			d = {neotest.run.run({strategy = 'dap'}), 'Debub nearest'},
			f = {neotest.run.run(vim.fn.expand('%'),{strategy = 'dap'}), 'Debub file'},
		},
		s = {neotest.run.stop(), 'Stop nearest'},
		a = {neotest.run.attatch(), 'Attatch to nearest'}
	}
})
