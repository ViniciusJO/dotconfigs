return {
  'lewis6991/gitsigns.nvim',
  opts = {
    on_attach = function(bufnr)
      local gitsigns = require('gitsigns')

      -- Navigation
      vim.keymap.set('n', ']g', function()
        if vim.wo.diff then
          vim.cmd.normal({ ']c', bang = true })
        else
          gitsigns.nav_hunk('next')
        end
      end, { buffer = bufnr, desc = 'Gitsigns next hunk' })

      vim.keymap.set('n', '[g', function()
        if vim.wo.diff then
          vim.cmd.normal({ '[c', bang = true })
        else
          gitsigns.nav_hunk('prev')
        end
      end, { buffer = bufnr, desc = 'gitsigns previous hunk' })

      require('which-key').add({{ '<leader>s', desc='Gitsigns', noremap=true }})

      -- Actions
      vim.keymap.set('n', '<leader>ss', gitsigns.stage_hunk, { buffer = bufnr, desc = 'Gitsigns stage hunk' })
      vim.keymap.set('n', '<leader>sr', gitsigns.reset_hunk, { buffer = bufnr, desc = 'Gitsigns reset hunk' })

      vim.keymap.set('v', '<leader>ss', function()
        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { buffer = bufnr, desc = 'Gitsigns stage hunk line' })

      vim.keymap.set('v', '<leader>sr', function()
        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, { buffer = bufnr, desc = 'Gitsigns reset hunk line' })

      vim.keymap.set('n', '<leader>sS', gitsigns.stage_buffer, { buffer = bufnr, desc = 'Gitsigns stage buffer' })
      vim.keymap.set('n', '<leader>sR', gitsigns.reset_buffer, { buffer = bufnr, desc = 'Gitsigns reset buffer' })
      vim.keymap.set('n', '<leader>sp', gitsigns.preview_hunk, { buffer = bufnr, desc = 'Gitsigns preview hunk' })
      vim.keymap.set('n', '<leader>si', gitsigns.preview_hunk_inline, { buffer = bufnr, desc = 'Gitsigns preview hunk inline' })

      vim.keymap.set('n', '<leader>sb', function()
        gitsigns.blame_line({ full = true })
      end, { buffer = bufnr, desc = 'Gitsigns blame line' })

      vim.keymap.set('n', '<leader>sd', gitsigns.diffthis, { buffer = bufnr, desc = 'Gitsigns diff' })

      vim.keymap.set('n', '<leader>sD', function()
        gitsigns.diffthis('~')
      end, { buffer = bufnr, desc = 'Gitsigns diff this' })

      vim.keymap.set('n', '<leader>sQ', function() gitsigns.setqflist('all') end, { buffer = bufnr, desc = 'Gitsigns qflist all' })
      vim.keymap.set('n', '<leader>sq', gitsigns.setqflist, { buffer = bufnr, desc = 'Gitsigns qflist' })

      -- Toggles
      require('which-key').add({{ '<leader>st', desc='Toggle', noremap=true }})
      vim.keymap.set('n', '<leader>stb', gitsigns.toggle_current_line_blame, { buffer = bufnr, desc = 'Gitsigns toggle line blame' })
      ---@diagnostic disable-next-line: deprecated
      vim.keymap.set('n', '<leader>std', gitsigns.toggle_deleted, { buffer = bufnr, desc = 'Gitsigns toggle deleted' })
      vim.keymap.set('n', '<leader>stw', gitsigns.toggle_word_diff, { buffer = bufnr, desc = 'Gitsigns toggle world diff' })

      -- Text object
      vim.keymap.set({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { buffer = bufnr, desc = 'Gitsigns select hunk' })
    end
  }
}
