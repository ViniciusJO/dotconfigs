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
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ['<C-u>'] = false,
          ['<C-d>'] = false,
        },
      },
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
        --n = { require('telescope').extensions.notify.notify, 'Find Notify' },
        ['/'] = { function()
          tel_builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end, 'Find /: Fuzzily search in current buffer'
        }
      }
    })
  end
}
