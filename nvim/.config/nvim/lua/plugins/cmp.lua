return {
  'hrsh7th/nvim-cmp',                   -- Autocompletions
  event = 'InsertEnter',
  dependencies = {
    'L3MON4D3/LuaSnip',                 -- Snippets engine
    'saadparwaiz1/cmp_luasnip',         -- Snippets autocompletions
    -- 'rafamadriz/friendly-snippets',     -- Snippets
    'hrsh7th/cmp-nvim-lsp',             -- Lsp autocompletions
    'hrsh7th/cmp-calc',
    -- 'FelipeLema/cmp-async-path',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-buffer',
  },
  init = function()
    -- [[ Configure nvim-cmp ]]
    -- See `:help cmp`
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    -- require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete {},
        ['<CR>'] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'path' },
        { name = 'calc' },
        { name = 'nvim_lsp' },
        { name = 'command' },
        { name = 'luasnip' },
        { name = 'buffer' },
      },
      border = {
        completion = true,
        documentation = true
      },
      -- window = {
      --
      --   completion = {
      --     -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      --     border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      --     winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
      --   },
      --   documentation = {
      --     border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      --     winhighlight = "Normal:CmpPmenu,FloatBorder:CmpBorder,CursorLine:PmenuSel,Search:None",
      --   },
      -- },
    }

    -- The line beneath this is called `modeline`. See `:help modeline`
    -- vim: ts=2 sts=2 sw=0 et
    --
  end
}
