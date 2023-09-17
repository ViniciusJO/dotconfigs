require('configs.lazy').bootstrap()

require('lazy').setup({
  { 'folke/which-key.nvim',   opts = {} },                                  -- Keymaps helper
  { 'tpope/vim-fugitive' },                                                 -- Git integration
  { 'lewis6991/gitsigns.nvim' },                                            -- Git signalization
  { 'tpope/vim-sleuth' },                                                   -- Fix tabstops
  { 'echasnovski/mini.nvim',  version = '*' },
  { 'ThePrimeagen/harpoon',   dependencies = { 'nvim-lua/plenary.nvim' } }, -- Movement arround marked files
  {
    'nvim-neo-tree/neo-tree.nvim',                                          -- File tree
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      'miversen33/netman.nvim'
    },
  },
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies =
    'nvim-tree/nvim-web-devicons'
  }, -- Shows buffers and tabs in a pretty way
  {
    's1n7ax/nvim-window-picker',
    name = 'window-picker',
    event = 'VeryLazy',
    version = '2.*'
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },  -- Adapters package manager
      'williamboman/mason-lspconfig.nvim',           -- LSP Mason integration
      { 'j-hui/fidget.nvim',       tag = 'legacy' }, -- Shows tasks progress
      'folke/neoconf.nvim',
      'folke/neodev.nvim',                           -- Neovim completions and lsp
    },
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
  },
  {
    'hrsh7th/nvim-cmp',               -- Autocompletions
    dependencies = {
      'L3MON4D3/LuaSnip',             -- Snippets engine
      'saadparwaiz1/cmp_luasnip',     -- Snippets autocompletions
      'rafamadriz/friendly-snippets', -- Snippets
      'hrsh7th/cmp-nvim-lsp',         -- Lsp autocompletions
      'hrsh7th/cmp-calc',
      'FelipeLema/cmp-async-path',
      'hrsh7th/cmp-buffer',
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },
  {
    "utilyre/barbecue.nvim", -- Winbar navic context
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
  },
  { 'kevinhwang91/nvim-ufo',            dependencies = 'kevinhwang91/promise-async' },
  {
    "folke/todo-comments.nvim", -- TODO pretty coments
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { 'stevearc/dressing.nvim', },

  -- Themes
  { 'wuelnerdotexe/vim-enfocado',       priority = 1000 },
  { 'whatsthatsmell/codesmell_dark.vim' },
  { 'catppuccin/nvim',                  name = 'catppuccin',                        priority = 1000 },
  { 'rebelot/kanagawa.nvim',            priority = 1000 },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },


  { 'nvim-lualine/lualine.nvim' },                     -- Lualine e statusline
  { 'lukas-reineke/indent-blankline.nvim' },           -- Identation lines
  { 'numToStr/Comment.nvim',              opts = {} }, -- "gc" to comment visual regions/lines
  {
    'nvim-telescope/telescope.nvim',                   -- Fuzzy finder
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
    },
  },
  {
    'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', 'JoosepAlviste/nvim-ts-context-commentstring' },
    build = ':TSUpdate',
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "antoinemadec/FixCursorHold.nvim",
      -- Addapters
      'marilari88/neotest-vitest',
      'nvim-neotest/neotest-plenary',
    }
  },



  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',
}, {})
