return {
  'echasnovski/mini.nvim',
  version = '*',
  init = function()
    require('mini.animate').setup()
    require('mini.bracketed').setup()
    require('mini.bufremove').setup()
    --require('mini.completion').setup()
    require('mini.cursorword').setup()
    --require('mini.diff').setup()
    --require('mini.git').setup()
    require('mini.move').setup()
    require('mini.operators').setup()
    require('mini.pairs').setup()
    require('mini.sessions').setup()
    require('mini.starter').setup()
    -- require('mini.statusline').setup()
    require('mini.surround').setup()
    -- require('mini.tabline').setup()
    require('mini.indentscope').setup({
      draw = {
        delay = 100,
        priority = 2,
      },
      options = {
        border = 'both',
        indent_at_cursor = true,
        try_as_border = false,
      },
      init = function()
        vim.api.nvim_create_autocmd('FileType', {
          pattern = {
            'alpha',
            'coc-explorer',
            'dashboard',
            'fzf',
            'help',
            'lazy',
            'lazyterm',
            'lspsagafinder',
            'mason',
            'neo-tree',
            'nnn',
            'notify',
            'NvimTree',
            'qf',
            'starter',
            'toggleterm',
            'Trouble',
          },
          callback = function()
            vim.b.miniindentscope_disable = true
            vim.schedule(function()
              if MiniIndentscope then MiniIndentscope.undraw() end
            end)
          end,
        })
      end,
    })
  end
}
