return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua",              -- optional
    "echasnovski/mini.pick",         -- optional
  },
  config = true,
  init = function()
    vim.keymap.set({ "n", "v" }, "<leader>n", ":Neogit<cr>", { desc = "Neogit", noremap = true, silent = true })
  end
}
