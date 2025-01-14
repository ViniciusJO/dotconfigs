-- Source configs
vim.keymap.set("n", "<leader>r", "<cmd>source ~/.config/nvim/init.lua<CR>", { desc = 'Source configs' })

-- jj go to ormal mode
vim.keymap.set({ "i", "t" }, "jj", "<esc>")

-- Keymaps for save and quit
vim.keymap.set('n', '<C-s>', '<cmd>w<cr>', { desc = 'Save buffer to file', silent = true })
vim.keymap.set('n', '<C-q>', '<cmd>q<cr>', { desc = 'Quit window', silent = true })
vim.keymap.set('n', '<C-Q>', '<cmd>q!<cr>', { desc = 'Quit window', silent = true })

-- Keymap for sourcing
vim.keymap.set('n', '<leader>r', '<cmd>source $HOME/.config/nvim/init.lua<cr>', { desc = 'Source configs' })

-- Copy to systems clipboard
vim.keymap.set('n', 'Y', '"+y', { desc = 'Yank to systems clipboard' });
vim.keymap.set('v', '<C-c>', '"+y', { desc = 'Yank to systems clipboard' });

-- Go to help
vim.keymap.set('n', 'gh', function() vim.cmd("h " .. vim.fn.expand("<cword>")) end, { desc = "Goto help", noremap = true, silent = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Disable arrows
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<Up>', '<Nop>', { silent = true})
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<Down>', '<Nop>', { silent = true})
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<Left>', '<Nop>', { silent = true})
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<Right>', '<Nop>', { silent = true})
local arrow_state = false
vim.keymap.set({ 'n', 't', 'i', 'v' }, '<M-a>', function ()
  vim.keymap.set({ 'n', 't', 'i', 'v' }, '<Up>', arrow_state and '<Nop>' or '<Up>', { silent = true})
  vim.keymap.set({ 'n', 't', 'i', 'v' }, '<Down>', arrow_state and '<Nop>' or '<Down>', { silent = true})
  vim.keymap.set({ 'n', 't', 'i', 'v' }, '<Left>', arrow_state and '<Nop>' or '<Left>', { silent = true})
  vim.keymap.set({ 'n', 't', 'i', 'v' }, '<Right>', arrow_state and '<Nop>' or '<Right>', { silent = true})
  arrow_state = not arrow_state
end, { desc = "Toggle arrow keys", noremap = true, silent = true})

-- Movement on insert mode
vim.keymap.set({ 'i', 't' }, '<C-k>', '<Up>', { noremap = true, silent = true })
vim.keymap.set({ 'i', 't' }, '<C-j>', '<Down>', { noremap = true, silent = true })
vim.keymap.set({ 'i', 't' }, '<C-h>', '<Left>', { noremap = true, silent = true })
vim.keymap.set({ 'i', 't' }, '<C-l>', '<Right>', { noremap = true, silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Toggle options
vim.keymap.set('n', '<M-z>', function() if(vim.o.wrap) then vim.o.wrap = false else vim.o.wrap = true end end, {desc = 'Toggle wrap', expr = true})
vim.keymap.set('n', '<M-r>', function() if(vim.o.relativenumber) then vim.o.relativenumber = false else vim.o.relativenumber = true end end, {desc = 'Toggle relative collumn number', expr = true})

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

-- Macros
vim.keymap.set('n', 'Q', '@q', { desc = 'Plays macro at q' })
vim.keymap.set('x', 'Q', ':norm @q<CR>', { desc = 'Plays macro at q on each lines selected' })

-- Netrw
--vim.keymap.set("n", "<leader>e", ":25Lex<CR>", { desc = 'Toggles netrw tree view' })

-- Terminal
vim.keymap.set('n', '<leader>x', '<cmd>split | term<CR>', { noremap = true, silent = true, desc = 'Toggle split terminal' })
vim.keymap.set('n', '<leader>X', '<cmd>vsplit | term<CR>', { noremap = true, silent = true, desc = 'Toggle split terminal [vertcal]' })
vim.keymap.set('t', '<esc><esc>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Unfocus terminal' })

-- Visual Maps
vim.keymap.set("v", "<leader>r", "\"hy:%s/<C-r>h//g<left><left>", { desc = 'Replace all instances of highlighted words' })
vim.keymap.set("v", "<C-s>", "<cmd>sort<CR>", { desc = 'Sort highlighted text' })
vim.keymap.set("v", "J", "<cmd>m '>+1<CR>gv=gv", { desc = 'Move current line down' })
-- FIX: Multi line select not moving (need to know how many lines are selected to make the move: m '>[+-]{number_of_lines+1})
vim.keymap.set("v", "K", "<cmd>m '>-2<CR>gv=gv", { desc = 'Move current line up' })

-- Autometic close match
-- vim.keymap.set("i", "'", "''<left>")
-- vim.keymap.set("i", "\"", "\"\"<left>")
-- vim.keymap.set("i", "(", "()<left>")
-- vim.keymap.set("i", "[", "[]<left>")
-- vim.keymap.set("i", "{", "{}<left>")
-- vim.keymap.set("i", "{;", "{};<left><left>")
-- vim.keymap.set("i", "/*", "/**/<left><left>")

