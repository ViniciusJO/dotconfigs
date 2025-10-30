return {
  "ej-shafran/compile-mode.nvim",
  -- you can just use the latest version:
  -- branch = "latest",
  -- or the most up-to-date updates:
  -- branch = "nightly",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- if you want to enable coloring of ANSI escape codes in
    -- compilation output, add:
    { "m00qek/baleia.nvim", tag = "v1.3.0" },
  },
  config = function()
    ---@type CompileModeOpts
    vim.g.compile_mode = {
        -- to add ANSI escape code support, add:
        baleia_setup = true,
    }

    require('which-key').add({{ '<leader>c', desc='Compile', noremap=true }})
    vim.keymap.set('n', '<leader>cc', ':Compile<cr>', { desc = 'Compile mode' })

    require('which-key').add({{ '<leader>cn', desc='Next', noremap=true }})
    vim.keymap.set('n', '<leader>cnf', ':CompileNextFile<cr>', { desc = 'Next file' })
    vim.keymap.set('n', '<leader>cne', ':CompileNextError<cr>', { desc = 'Next error' })

    require('which-key').add({{ '<leader>cp', desc='Previous', noremap=true }})
    vim.keymap.set('n', '<leader>cpf', ':CompilePrevFile<cr>', { desc = 'Previous file' })
    vim.keymap.set('n', '<leader>cpe', ':CompilePrevError<cr>', { desc = 'Previous error' })


    vim.keymap.set('n', '<leader>cd', ':CompileDebugError<cr>', { desc = 'Debug error' })
    vim.keymap.set('n', '<leader>cg', ':CompileGotoError<cr>', { desc = 'Goto error' })
    vim.keymap.set('n', '<leader>ci', ':CompileInterrupt<cr>', { desc = 'Interrupt' })
  end
}
