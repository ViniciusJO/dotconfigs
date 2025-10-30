return {
  "leobeosab/stupyder.nvim",
  init = function(_)
    require("stupyder").setup({
      run_options = { print_debug_info = false, default_mode = "win" },
      modes = {
        win = { close_shortcut = "q" },
        yank = {
          --default
          register = '*'

          --unnamed clipboard
          --register = '"'

          --unnamedplus clipboard
          --register = '+'
        }
      }
    })
  end
}
