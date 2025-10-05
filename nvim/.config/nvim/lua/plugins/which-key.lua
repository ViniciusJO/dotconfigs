return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    require('which-key').add({{ '<leader>b', desc='Buffer', noremap=true }})
    require('which-key').add({{ '<leader>t', desc='Tab', noremap=true }})
  end,
}
