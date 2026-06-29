return {
  'nvim-treesitter/nvim-treesitter', -- Highlight, edit, and navigate code
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'JoosepAlviste/nvim-ts-context-commentstring'
  },
  build = ':TSUpdate',
  opts = {
    sync_install = false,
    ignore_install = {},
    -- Add languages to be installed here that you want installed for treesitter
    -- dockerfile bash yaml xml toml svelte html css javascript typescript asm python rust sql ssh_config c cpp csv json git_config gitattributes gitcommit gitignore markdown make matlab nasm properties regex strace udev vim zathurarc
    ensure_installed = {
      'arduino',
      'asm',
      'awk',
      'bash',
      'bibtex',
      'c',
      'css',
      'csv',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'html',
      'http',
      'ini',
      'jsdoc',
      'json',
      'json5',
      'jsonc',
      'latex',
      'llvm',
      'lua',
      'luadoc',
      'make',
      'markdown',
      'markdown_inline',
      'matlab',
      'meson',
      'nasm',
      'nginx',
      'pem',
      'properties',
      'proto',
      'query',
      'regex',
      'sql',
      'tmux',
      'udev',
      'vhdl',
      'vim',
      'vimdoc',
      'xml',
      'yaml'
    },
    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
    context_commentstring = {
      enable = true
    }
  }
}
