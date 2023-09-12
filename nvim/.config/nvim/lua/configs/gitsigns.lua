local gs = require('gitsigns')
gs.setup({
  -- See `:help gitsigns.txt`
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    require("which-key").register({
      ['<leader>h'] = {
        name = "Gitsign Hunk",
        p = { gs.prev_hunk, 'Goto  Previous', { buffer = bufnr } },
        n = { gs.next_hunk, 'Goto Next', { buffer = bufnr } },
        P = { gs.preview_hunk, 'Preview', { buffer = bufnr } },
      },
    })
  end,
})
