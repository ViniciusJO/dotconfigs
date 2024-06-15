return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = function()
    require('telescope.actions')
    local trouble = require('trouble')
    trouble.setup()

    require('which-key').register({
      ['<leader>t'] = { trouble.toggle, 'Trouble' },
    })
  end
}
