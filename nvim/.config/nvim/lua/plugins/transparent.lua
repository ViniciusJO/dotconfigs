return {
  "xiyaowong/transparent.nvim",
  init = function()
    require('which-key').register({
      ['<leader>.'] = { "<cmd>TransparentToggle<cr>", "Toogle transparency" }
    })
  end
}
