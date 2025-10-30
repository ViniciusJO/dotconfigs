local function close_empty_buffers()
  local function is_buffer_empty(bufnr)
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    return #lines == 1 and #lines[1] == 0
  end

  local current_bufnr = vim.api.nvim_get_current_buf()
  local empty_buffers = {}

  -- Iterate through all buffers
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    -- Check if buffer is empty and not the current buffer
    if is_buffer_empty(bufnr) and bufnr ~= current_bufnr then
      table.insert(empty_buffers, bufnr)
    end
  end

  -- Close all empty buffers
  for _, bufnr in ipairs(empty_buffers) do
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end
end

local function exec_and_close_empty_buffers(func)
  func()
  close_empty_buffers()
end

return {
  'nvim-telescope/telescope.nvim', -- Fuzzy finder
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'debugloop/telescope-undo.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
      -- configure to use ripgrep
      vimgrep_arguments = {
        "rg",
        "--follow",        -- Follow symbolic links
        "--hidden",        -- Search for hidden files
        "--no-heading",    -- Don't group matches by each file
        "--with-filename", -- Print the file path with the matched lines
        "--line-number",   -- Show line numbers
        "--column",        -- Show column numbers
        "--smart-case",    -- Smart case search

        -- Exclude some patterns from search
        "--glob=!**/.git/*",
        "--glob=!**/.idea/*",
        "--glob=!**/.vscode/*",
        "--glob=!**/build/*",
        "--glob=!**/dist/*",
        "--glob=!**/yarn.lock",
        "--glob=!**/package-lock.json",
      },

      ...

    },
    pickers = {
      find_files = {
        hidden = true,
        -- needed to exclude some files & dirs from general search
        -- when not included or specified in .gitignore
        find_command = {
          "rg",
          "--files",
          "--hidden",
          "--glob=!**/.git/*",
          "--glob=!**/.idea/*",
          "--glob=!**/.vscode/*",
          "--glob=!**/build/*",
          "--glob=!**/dist/*",
          "--glob=!**/yarn.lock",
          "--glob=!**/package-lock.json",
        },
      },
      -- file_ignore_patterns = {
      --   "node_modules", "build", "dist", "yarn.lock"
      -- },
    },
  },
  init = function()
    local telescope = require('telescope')
    -- Enable telescope extensions, if installed
    pcall(telescope.load_extension, 'fzf')
    --pcall(telescope.load_extension, 'harpoon')
    --pcall(telescope.load_extension, 'notify')
    pcall(telescope.load_extension, 'undo')
    --pcall(telescope.load_extension, 'noice')
    pcall(telescope.load_extension, 'file_browser')

    -- See `:help telescope.builtin`
    local tel_builtin = require('telescope.builtin')

    require('which-key').add({ { '<leader>f', desc = 'Telescope Find', remap = false } })
    vim.keymap.set('n', '<leader>fo', tel_builtin.oldfiles, { desc = 'Find recently Opened files' })
    vim.keymap.set('n', '<leader>fb', tel_builtin.buffers, { desc = 'Find existing Buffers' })
    vim.keymap.set('n', '<leader>fg', tel_builtin.git_files, { desc = 'Find Git Files' })
    vim.keymap.set('n', '<leader>ff', tel_builtin.find_files, { desc = 'Find File' })
    vim.keymap.set('n', '<leader>fh', tel_builtin.help_tags, { desc = 'Find Help' })
    vim.keymap.set('n', '<leader>fw', tel_builtin.grep_string, { desc = 'Find Word' })
    vim.keymap.set('n', '<leader>fl', tel_builtin.live_grep, { desc = 'Find Live Grep' })
    vim.keymap.set('n', '<leader>fd', tel_builtin.diagnostics, { desc = 'Find Diagnostics' })
    vim.keymap.set('n', '<leader>fr', tel_builtin.resume, { desc = 'Find Resume' })
    vim.keymap.set('n', '<leader>ft', require('telescope').extensions.file_browser.file_browser, { desc = 'File tree' })
    vim.keymap.set('n', '<leader>f/',
      function()
        tel_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end,
      { desc = 'Find /: Fuzzily search in current buffer' }
    )

    -- require('which-key').register({
    --   ['<leader>f'] = {
    --     name = 'Telescope',
    --     o = { tel_builtin.oldfiles, 'Find recently Opened files' },
    --     b = { tel_builtin.buffers, 'Find existing Buffers' },
    --     g = { tel_builtin.git_files, 'Find Git Files' },
    --     f = { tel_builtin.find_files, 'Find File' },
    --     h = { tel_builtin.help_tags, 'Find Help' },
    --     w = { tel_builtin.grep_string, 'Find Word' },
    --     l = { tel_builtin.live_grep, 'Find Live Grep' },
    --     d = { tel_builtin.diagnostics, 'Find Diagnostics' },
    --     r = { tel_builtin.resume, 'Find Resume' },
    --     t = { require('telescope').extensions.file_browser.file_browser, 'File tree' },
    --     --n = { r'telescope').extensions.notify.notif, 'Find Notify' },
    --     ['/'] = { function()
    --       tel_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    --         winblend = 10,
    --         previewer = false,
    --       })
    --     end, 'Find /: Fuzzily search in current buffer'
    --     }
    --   }
    -- })
  end
}



-- require('which-key').register({
--   ['<leader>f'] = {
--     name = 'Telescope',
--     o = { exec_and_close_empty_buffers(tel_builtin.oldfiles), 'Find recently Opened files' },
--     b = { exec_and_close_empty_buffers(tel_builtin.buffers), 'Find existing Buffers' },
--     g = { exec_and_close_empty_buffers(tel_builtin.git_files), 'Find Git Files' },
--     f = { exec_and_close_empty_buffers(tel_builtin.find_files), 'Find File' },
--     h = { exec_and_close_empty_buffers(tel_builtin.help_tags), 'Find Help' },
--     w = { exec_and_close_empty_buffers(tel_builtin.grep_string), 'Find Word' },
--     l = { exec_and_close_empty_buffers(tel_builtin.live_grep), 'Find Live Grep' },
--     d = { exec_and_close_empty_buffers(tel_builtin.diagnostics), 'Find Diagnostics' },
--     r = { exec_and_close_empty_buffers(tel_builtin.resume), 'Find Resume' },
--     t = { exec_and_close_empty_buffers(require('telescope').extensions.file_browser.file_browser), 'File tree' },
--     --n = { require('telescope').extensions.notify.notify, 'Find Notify' },
--     ['/'] = { function()
--       tel_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--         winblend = 10,
--         previewer = false,
--       })
--     end, 'Find /: Fuzzily search in current buffer'
--     }
--   }
-- })
