-- gitsigns
-- neotest
-- noice
-- indent-blankline

require('plugins.lazy').bootsrap()

require('lazy').setup({
  require('plugins.cmp'),
  require('plugins.lsp'),
  require('plugins.dap'),
  require('plugins.treesiter'),
  require('plugins.mini'),
  require('plugins.ufu'),
  require('plugins.trouble'),
  require('plugins.undo-tree'),
  require('plugins.which-key'),
  require('plugins.neo-tree'),
  require('plugins.telescope'),
  -- require('plugins.twoslash-queries'),
  -- require('plugins.dressing'),
  -- require('plugins.lualine'),
  require('plugins.bufferline'),
  -- require('plugins.barbecue'),
  require('plugins.transparent'),
  require('plugins.todo-comments'),
  require('plugins.theme'),
  require('plugins.colorizer'),
  require('plugins.hex'),
  require('plugins.kanban'),
  require('plugins.hover'),
  require('plugins.indent-blankline'),
  -- require('plugins.barbecue'),
  require('plugins.navic'),
  require('plugins.log_highlight'),
  -- require('plugins.llama'),
  -- require('plugins.lazygit'),
  require('plugins.compile_mode'),
  require('plugins.dired'),
  require('plugins.neogit'),
  require('plugins.multicursors'),
  require('plugins.dataviewer'),
})
-- fidget
