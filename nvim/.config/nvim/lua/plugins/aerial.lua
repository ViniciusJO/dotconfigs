return {
  'stevearc/aerial.nvim',
  opts = {
    on_attach = function(bufnr)
      -- Jump forwards/backwards with '{' and '}'
      vim.keymap.set("n", "<leader>a{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
      vim.keymap.set("n", "<leader>a}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    end,
  },
  -- Optional dependencies
  dependencies = {
     "nvim-treesitter/nvim-treesitter",
     "nvim-tree/nvim-web-devicons"
  },
  init = function ()
    require('which-key').add({{ "<leader>a", desc = "Aerial" }})
    vim.keymap.set("n", "<leader>aa", "<cmd>AerialToggle!<CR>")
  end

}
