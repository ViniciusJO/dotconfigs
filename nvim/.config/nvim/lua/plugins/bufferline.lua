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

  end
}
