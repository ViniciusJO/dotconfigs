return {
  "marilari88/twoslash-queries.nvim",
  options = {
    multi_line = true,    -- to print types in multi line mode
    is_enabled = false,   -- to keep disabled at startup and enable it on request with the TwoslashQueriesEnable
    highlight = "Type",   -- to set up a highlight group for the virtual text
  },
  init = function()
    require("lspconfig")["tsserver"].setup({
      on_attach = function(client, bufnr)
        require("twoslash-queries").attach(client, bufnr)
      end,
    })

    require('which-key').register({
      ['<leader>l/'] = { "<cmd>TwoslashQueriesInspect<CR>", 'Two Slash Inspect' },

    })
  end,
}
