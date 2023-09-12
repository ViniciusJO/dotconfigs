-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
local tel_builtin = require('telescope.builtin')
require('which-key').register({
  ['<leader>f'] = {
    name = 'Telescope',
    o = { tel_builtin.oldfiles, 'Find recently Opened files' },
    b = { tel_builtin.buffers, 'Find existing Buffers' },
    g = { tel_builtin.git_files, 'Find Git Files' },
    f = { tel_builtin.find_files, 'Find File' },
    h = { tel_builtin.help_tags, 'Find Help' },
    w = { tel_builtin.grep_string, 'Find Word' },
    l = { tel_builtin.live_grep, 'Find Live Grep' },
    d = { tel_builtin.diagnostics, 'Find Diagnostics' },
    r = { tel_builtin.resume, 'Find Resume' },
    ['/'] = { function()
      tel_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, 'Find /: Fuzzily search in current buffer'
    }
  }
})
