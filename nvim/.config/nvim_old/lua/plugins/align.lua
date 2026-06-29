return {
  'Vonr/align.nvim',
  branch = "v2",
  lazy = true,
  init = function()
    vim.keymap.set(
      'x',
      '<leader>=a',
      function()
        require'align'.align_to_char({
          length = 1,
        })
      end,
      { noremap = true, silent = true, desc = "Aligns to 1 character" }
    )

    vim.keymap.set(
      'x',
      '<leader>=d',
      function()
        require'align'.align_to_char({
          preview = true,
          length = 2,
        })
      end,
      { noremap = true, silent = true, desc = "Aligns to 2 characters with previews" }
    )

    vim.keymap.set(
      'x',
      '<leader>=w',
      function()
        require'align'.align_to_string({
          preview = true,
          regex = false,
        })
      end,
      { noremap = true, silent = true, desc = "Aligns to a string with previews" }
    )

    vim.keymap.set(
      'x',
      '<leader>=r',
      function()
        require'align'.align_to_string({
          preview = true,
          regex = true,
        })
      end,
      { noremap = true, silent = true, desc = "Aligns to a Vim regex with previews" }
    )

    vim.keymap.set(
      'n',
      'gaw',
      function()
        local a = require'align'
        a.operator(
          a.align_to_string,
          {
            regex = false,
            preview = true,
          }
        )
      end,
      { noremap = true, silent = true, desc = "Example gawip to align a paragraph to a string with previews" }
    )

    vim.keymap.set(
      'n',
      'gaa',
      function()
        local a = require'align'
        a.operator(a.align_to_char)
      end,
      { noremap = true, silent = true, desc = "Example gaaip to align a paragraph to 1 character" }
    )
  end
}
