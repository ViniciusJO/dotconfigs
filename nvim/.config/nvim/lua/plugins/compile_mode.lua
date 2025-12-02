--- get_compile_buffer
---@return integer
local function get_compilation_buffer()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    -- Check if the buffer is valid and loaded
    if vim.api.nvim_buf_is_valid(bufnr) and vim.api.nvim_buf_get_option(bufnr, 'buflisted') then
      local filetype = vim.api.nvim_buf_get_option(bufnr, 'filetype')
      if filetype == 'compilation' then
        return bufnr -- Found a buffer with filetype 'compilation'
      end
    end
  end
  return -1 -- No buffer with filetype 'compilation' found
end

--- 
---@param bufnr_to_find integer
---@return boolean
local function jump_to_buffer_in_window(bufnr_to_find)
  local all_tabpages = vim.api.nvim_list_tabpages()

  for _, tabpage in ipairs(all_tabpages) do
    local win_list = vim.api.nvim_tabpage_list_wins(tabpage)
    for _, win_id in ipairs(win_list) do
      local current_buf_in_win = vim.api.nvim_win_get_buf(win_id)
      if current_buf_in_win == bufnr_to_find then
        vim.api.nvim_set_current_win(win_id)
        return true -- Buffer found and jumped to
      end
    end
  end
  return false -- Buffer not found in any window
end

--- Exec function in other buffer
---@param bufnr integer
---@param fn function
local function do_in_other_buffer(bufnr, fn, report)
  local cb = vim.api.nvim_get_current_buf();
  if bufnr >= 0 then
    jump_to_buffer_in_window(bufnr);
    fn();
    jump_to_buffer_in_window(cb);
  elseif report then
    error("Buffer "..bufnr.." not found");
  end
end

-- TODO: make compilation window automaticaly close when its the last remaining

-- Example usage:
return {
  "ej-shafran/compile-mode.nvim",
  -- you can just use the latest version:
  -- branch = "latest",
  -- or the most up-to-date updates:
  -- branch = "nightly",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- if you want to enable coloring of ANSI escape codes in
    -- compilation output, add:
    { "m00qek/baleia.nvim", tag = "v1.3.0" },
  },
  config = function()
    ---@type CompileModeOpts
    vim.g.compile_mode = {
        input_word_completion = true,
        bang_expansion = true,
        use_diagnostics = true,
        -- to add ANSI escape code support, add:
        baleia_setup = true,
    }

    local cm = require('compile-mode')

    require('which-key').add({{ '<leader>c', desc='Compile', noremap=true }})
    vim.keymap.set('n', '<leader>cc', function()
      local bufnr = get_compilation_buffer();
      if bufnr >= 0 then
        cm.recompile();
      else
        cm.compile();
        cm.send_to_qflist();
      end
		end, { desc = 'Compile mode' })


    -- Closes compilation window if the last one open
    vim.api.nvim_create_autocmd("BufEnter", {
      callback = function()
        local ws = vim.api.nvim_list_wins();
        local b = vim.api.nvim_win_get_buf(ws[1]);
        if #ws == 1 and vim.bo[b].filetype == 'compilation' then
          vim.print("Only this");
          vim.cmd.quit();
        end
      end
    });


    vim.keymap.set('n', ']e', function()
      local bufnr = get_compilation_buffer();
      do_in_other_buffer(bufnr, function()
        vim.o.cursorline = true;
        -- TODO: find a way to keep the compilation window oppened
        cm.move_to_next_error();
      end)
		end, { desc = 'Next compilation error' })

    vim.keymap.set('n', '[e', function()
      local bufnr = get_compilation_buffer();
      do_in_other_buffer(bufnr, function()
        vim.o.cursorline = true;
        -- TODO: find a way to keep the compilation window oppened
        cm.move_to_prev_error();
        -- cm.goto_error();
      end)
		end, { desc = 'Previous compilation error' })



    require('which-key').add({{ '<leader>cn', desc='Next', noremap=true }})
    vim.keymap.set('n', '<leader>cnf', function()
			vim.cmd('CompileNextFile')
		end, { desc = 'Next file' })
    vim.keymap.set('n', '<leader>cne', function()
			vim.cmd('CompileNextError')
		end, { desc = 'Next error' })

    require('which-key').add({{ '<leader>cp', desc='Previous', noremap=true }})
    vim.keymap.set('n', '<leader>cpf', function()
			vim.cmd('CompilePrevFile')
		end, { desc = 'Previous file' })
    vim.keymap.set('n', '<leader>cpe', function()
			vim.cmd('CompilePrevError')
		end, { desc = 'Previous error' })


    vim.keymap.set('n', '<leader>cd', function()
			vim.cmd('CompileDebugError')
		end, { desc = 'Debug error' })
    vim.keymap.set('n', '<leader>cg', function()
			vim.cmd('CompileGotoError')
		end, { desc = 'Goto error' })
    vim.keymap.set('n', '<leader>ci', function()
			vim.cmd('CompileInterrupt')
		end, { desc = 'Interrupt' })
  end
}
