return {
  'mbbill/undotree',
  init = function()
    vim.keymap.set('n', '<leader>u', require('telescope').extensions.undo.undo, { desc = 'Undotree Toggle' })
    vim.keymap.set('n', '<leader>fu', require('telescope').extensions.undo.undo, { desc = 'Find Undo History' })
    -- require('which-key').register({
    --   ['<leader>u'] = { require('telescope').extensions.undo.undo, 'Undotree Toggle' },
    --   ['<leader>fu'] = { require('telescope').extensions.undo.undo, 'Find Undo History' }
    -- })
  end
}
