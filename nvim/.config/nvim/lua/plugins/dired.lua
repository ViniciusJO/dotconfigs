return {
  "X3eRo0/dired.nvim",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("dired").setup {
      path_separator = "/",
      show_banner = false,
      show_icons = false,
      show_hidden = true,
      show_dot_dirs = true,
      show_colors = true,
    }

    -- TODO: function to toogle dired buffer
    vim.keymap.set('n', '<M-e>', ':split | Dired<cr>', { desc = 'Dired', silent = true })
    vim.keymap.set('n', '<M-E>', ':vsplit | Dired<cr>', { desc = 'Dired', silent = true })
  end
}
