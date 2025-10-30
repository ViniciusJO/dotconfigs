return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    view_options = {
      show_hidden = true
    }
  },
  -- Optional dependencies
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons

  init = function ()
    -- local oil = require("oil")
    --
    -- vim.api.nvim_create_autocmd("VimEnter", {
    --   callback = function()
    --     local args = vim.fn.argv()
    --     local is_dir = #args == 1 and vim.fn.isdirectory(args[1]) == 1
    --
    --     if is_dir then
    --       vim.cmd("e " .. args[1]) -- Open the directory
    --       oil.open() -- Open it with oil.nvim
    --     end
    --   end,
    -- })
    --
    -- vim.api.nvim_create_autocmd("FileType", {
    --   pattern = "nofile",
    --   callback = function()
    --     oil.open() -- Open it with oil.nvim
    --   end,
    -- })

  end
};
