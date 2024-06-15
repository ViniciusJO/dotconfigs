return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    require('bufferline').setup({
      options = {
        themable = true,
        close_command = require('mini.bufremove').delete,
        right_mouse_command = require('mini.bufremove').delete,
        left_mouse_command = "buffer %d",
        middle_mouse_command = nil,
        indicator = {
          icon = '|',
          style = 'underline'
        },
        buffer_close_icon = 'x',
        modified_icon = '●',
        close_icon = 'x',
        left_trunc_marker = '',
        right_trunc_marker = '',
        show_buffer_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        color_icons = true,
        separator_style = "slope",
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Tree",
            highlight = "Directory",
            separator = true -- use a "true" to enable the default, or set your own character
          }
        },
        custom_areas = {
          right = function()
            local result = {}
            local seve = vim.diagnostic.severity
            local error = vim.diagnostic.get(0, { severity = seve.ERROR })
            local warning = vim.diagnostic.get(0, { severity = seve.WARN })
            local info = vim.diagnostic.get(0, { severity = seve.INFO })
            local hint = vim.diagnostic.get(0, { severity = seve.HINT })

            if error ~= 0 then
              table.insert(result, { text = "  " .. error, fg = "#EC5241" })
            end

            if warning ~= 0 then
              table.insert(result, { text = "  " .. warning, fg = "#EFB839" })
            end

            if hint ~= 0 then
              table.insert(result, { text = "  " .. hint, fg = "#A3BA5E" })
            end

            if info ~= 0 then
              table.insert(result, { text = "  " .. info, fg = "#7EA9A7" })
            end
            return result
          end,
        }

      }
    })

    require('which-key').register({
      --['>'] = { "<cmd>bnext<cr>" },
      --['<'] = { "<cmd>bprevious<cr>" },
      ['<C-c>'] = { require('mini.bufremove').delete, 'Quit window', { silent = true } },
      ['<leader>'] = {
        c = { require('mini.bufremove').delete, "Close Current Buffer" },
        --	b = {
        --		name = "Buffer",
        --		['1'] = { bufferline.go_to(1, true), 'Go to buffer 1' },
        --		['2'] = { bufferline.go_to(2, true), 'Go to buffer 2' },
        --		['3'] = { bufferline.go_to(3, true), 'Go to buffer 3' },
        --		['4'] = { bufferline.go_to(4, true), 'Go to buffer 4' },
        --		['5'] = { bufferline.go_to(5, true), 'Go to buffer 5' },
        --		['6'] = { bufferline.go_to(6, true), 'Go to buffer 6' },
        --		['7'] = { bufferline.go_to(7, true), 'Go to buffer 7' },
        --		['8'] = { bufferline.go_to(8, true), 'Go to buffer 8' },
        --		['9'] = { bufferline.go_to(9, true), 'Go to buffer 9' },
        --		['$'] = { bufferline.go_to(-1, true), 'Go to buffer $' },
        --	}
      }
    })
  end
}
