require('persistence').setup();

require('which-key').register({
	['<leader>q'] = {
		name = 'Session',
		s = { require("persistence").load(), 'Restore' },
		l = { require("persistence").load({ last = true }), 'Restore Last' },
		d = { require("persistence").stop(), 'Stop' }
	}
})
