vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Keymaps for save and quit
vim.keymap.set('n', '<C-s>', '<cmd>w<cr>', { desc = 'Save buffer to file', silent = true })
vim.keymap.set('n', '<C-q>', '<cmd>q<cr>', { desc = 'Quit window', silent = true })
vim.keymap.set('n', '<C-Q>', '<cmd>q!<cr>', { desc = 'Quit window', silent = true })

-- Keymap for sourcing
vim.keymap.set('n', '<leader><F11>', '<cmd>source $HOME/.config/nvim/init.lua<cr>', { desc = 'Source configs' })

-- Copy to systems clipboard
vim.keymap.set('n', 'Y', '"+y', { desc = 'Yank to systems clipboard' });
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Yank to systems clipboard' });

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', '<M-z>', function() if(vim.o.wrap) then vim.o.wrap = false else vim.o.wrap = true end end, {desc = 'Toggle wrap', expr = true})

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Resize window
vim.keymap.set('n', '<C-up>', '1<C-w>+', { noremap = true, silent = true, desc = 'Vertically resize windows (+)' })
vim.keymap.set('n', '<C-down>', '1<C-w>-', { noremap = true, silent = true, desc = 'Vertically resize windows (-)' })
vim.keymap.set('n', '<C-left>', '1<C-w>>', { noremap = true, silent = true, desc = 'Horizontally resize windows (+)' })
vim.keymap.set('n', '<C-right>', '1<C-w><', { noremap = true, silent = true, desc = 'Horizontally resize windows (-)' })

-- Clear search
vim.keymap.set('n', '<leader>h', '<cmd>set hlsearch!<CR>', { noremap = true, silent = true, desc = 'Toggle search highlight' })
