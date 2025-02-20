-- gitsigns
-- neotest
-- noice

require('plugins.lazy').bootstrap()

require('lazy').setup({
  { import = 'plugins.cmp' },
  { import = 'plugins.lsp' },
  { import = 'plugins.dap' },
  { import = 'plugins.treesiter' },
  { import = 'plugins.telescope' },
  { import = 'plugins.mini' },
  { import = 'plugins.ufu' },
  { import = 'plugins.trouble' },
  { import = 'plugins.undo-tree' },
  { import = 'plugins.which-key' },
  { import = 'plugins.fugitive' },
  { import = 'plugins.gitsigns' },
  { import = 'plugins.oil' },
  { import = 'plugins.neo-tree' },
  { import = 'plugins.compile_mode' },
  { import = 'plugins.twoslash-queries' },
  { import = 'plugins.bufferline' },
  { import = 'plugins.transparent' },
  { import = 'plugins.todo-comments' },
  { import = 'plugins.theme' },
  { import = 'plugins.colorizer' },
  { import = 'plugins.log_highlight' },
  { import = 'plugins.hex' },
  { import = 'plugins.dataviewer' },
  { import = 'plugins.vi-mongo' },
  { import = 'plugins.alpha' },
  { import = 'plugins.render-markdown' },
  { import = 'plugins.indent-blankline' },
  { import = 'plugins.multicursors' },
  { import = 'plugins.neogit' },
  --
  -- { import = 'plugins.arduino' },
  { import = 'plugins.hover' },
  --
  -- { import = 'plugins.dired' },
  -- { import = 'plugins.blink' },
  -- { import = 'plugins.dressing' },
  -- { import = 'plugins.lualine' },
  -- { import = 'plugins.navic' },
  -- { import = 'plugins.barbecue' },
  -- { import = 'plugins.kanban' },
  -- { import = 'plugins.llama' },
  -- { import = 'plugins.lazygit' },
  -- { import = 'plugins.dashboard' },
})
-- fidget
