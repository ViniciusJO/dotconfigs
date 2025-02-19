-- Disable netrw by removing its plugin and autoload directories from runtimepath
vim.opt.runtimepath:remove(vim.fn.stdpath('config') .. '/autoload/netrw.vim')
vim.opt.runtimepath:remove(vim.fn.stdpath('config') .. '/plugin/netrwPlugin.vim')
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Netrw
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3
--vim.cmd("let g:netrw_list_hide=netrw_gitignore#Hide()")

-- Set highlight on search
vim.o.hlsearch = true

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Wrap
vim.o.wrap = false

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Tabstop
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.smarttab = true
vim.o.expandtab = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect,preview'

vim.o.termguicolors = true

-- Clipboard
-- vim.o.clipboard = 'unnamedplus'


-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


-- Folds

-- Using UFU
--
-- vim.o.foldmethod = "syntax"
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- Using expr
--
-- vim.wo.foldmethod = "expr"
-- vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.wo.fillchars = "fold: "
-- vim.wo.foldnestmax = 3
-- vim.wo.foldminlines = 1
-- vim.wo.foldlevel = 1
-- vim.wo.foldtext =
-- [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
