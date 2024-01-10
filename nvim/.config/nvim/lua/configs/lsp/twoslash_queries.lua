require("lspconfig")["tsserver"].setup({
  on_attach = function(client, bufnr)
    require("twoslash-queries").attach(client, bufnr)
  end,
})

require('which-key').register({
  ['<leader>l/'] = { "<cmd>TwoslashQueriesInspect<CR>", 'Two Slash Inspect' },

})
