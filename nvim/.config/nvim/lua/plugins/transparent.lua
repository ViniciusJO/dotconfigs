return {
  "xiyaowong/transparent.nvim",
  init = function()
    vim.keymap.set('n', '<leader>.', '<cmd>TransparentToggle<cr>', { desc = 'Toogle transparency' })
    -- require('which-key').register({
    --   ['<leader>.'] = { "<cmd>TransparentToggle<cr>", "Toogle transparency" }
    -- })
  end
}
