return {
  'echasnovski/mini.nvim',
  version = '*',
  init = function()
    -- require('mini.animate').setup()
    require('mini.bracketed').setup()
    require('mini.bufremove').setup()
    --require('mini.completion').setup()
    require('mini.cursorword').setup()
    --require('mini.diff').setup()
    --require('mini.git').setup()
    require('mini.move').setup()
    require('mini.operators').setup()
    require('mini.pairs').setup()
    -- require('mini.sessions').setup()
    -- require('mini.starter').setup()
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
            'nofile',
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

    -- vim.keymap.set('n', '<C-c>', require('mini.bufremove').delete, { desc = 'Quit window', silent = true })
    vim.keymap.set('n', '<leader>bd', require('mini.bufremove').delete, { desc = 'Close Current Buffer', silent = true })
    -- require('which-key').register({
    --   --['>'] = { "<cmd>bnext<cr>" },
    --   --['<'] = { "<cmd>bprevious<cr>" },
    --   ['<C-c>'] = { require('mini.bufremove').delete, 'Quit window', { silent = true } },
    --   ['<leader>'] = {
    --     c = { require('mini.bufremove').delete, "Close Current Buffer" },
    --     --	b = {
    --     --		name = "Buffer",
    --     --		['1'] = { bufferline.go_to(1, true), 'Go to buffer 1' },
    --     --		['2'] = { bufferline.go_to(2, true), 'Go to buffer 2' },
    --     --		['3'] = { bufferline.go_to(3, true), 'Go to buffer 3' },
    --     --		['4'] = { bufferline.go_to(4, true), 'Go to buffer 4' },
    --     --		['5'] = { bufferline.go_to(5, true), 'Go to buffer 5' },
    --     --		['6'] = { bufferline.go_to(6, true), 'Go to buffer 6' },
    --     --		['7'] = { bufferline.go_to(7, true), 'Go to buffer 7' },
    --     --		['8'] = { bufferline.go_to(8, true), 'Go to buffer 8' },
    --     --		['9'] = { bufferline.go_to(9, true), 'Go to buffer 9' },
    --     --		['$'] = { bufferline.go_to(-1, true), 'Go to buffer $' },
    --     --	}
    --   }
    -- })

  end
}
