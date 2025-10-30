return {
  "danymat/neogen",
  config = true,
  init = function ()
    vim.keymap.set("n", "<leader>o", ":lua require('neogen').generate()<CR>", { noremap = true, silent = true, desc = "Neogen generate" })
  end
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
}
