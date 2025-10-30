return {
  "marilari88/twoslash-queries.nvim",
  options = {
    multi_line = true,    -- to print types in multi line mode
    is_enabled = false,   -- to keep disabled at startup and enable it on request with the TwoslashQueriesEnable
    highlight = "Type",   -- to set up a highlight group for the virtual text
  },
  init = function()
    require("lspconfig")["ts_ls"].setup({
      on_attach = function(client, bufnr)
        require("twoslash-queries").attach(client, bufnr)
      end,
    })

    vim.keymap.set('n', '<leader>l/', '<cmd>TwoslashQueriesInspect<cr>', { desc = 'Two Slash Inspect', noremap = true, silent = true })
  end,
}

-- tsserver is deprecated, use ts_ls instead.
-- Feature will be removed in lspconfig 0.2.1
-- Failed to run `init` for **twoslash-queries.nvim**
--
-- ...e/vinicius/.config/nvim/lua/plugins/twoslash-queries.lua:9: attempt to call field 'setup' (a nil value)
--
-- # stacktrace:
--   - ~/.config/nvim/lua/plugins/twoslash-queries.lua:9 _in_ **init**
--   - ~/.config/nvim/lua/plugins/init.lua:8
--   - init.lua:8
--
--
--
--
