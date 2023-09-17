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
		r = {neotest.run.run, 'Run nearest'},
		f = {function() neotest.run.run(vim.fn.expand('%')) end, 'Run file'	},
		d = {
			d = {function() neotest.run.run({strategy = 'dap'}) end, 'Debub nearest'},
			f = {function() neotest.run.run(vim.fn.expand('%'),{strategy = 'dap'}) end, 'Debub file'},
		},
		s = {neotest.run.stop, 'Stop nearest'},
		a = {neotest.run.attatch, 'Attatch to nearest'}
	}
})
