-- Makes terminal in insert mode on win enter
vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    if vim.bo.buftype == "terminal" then
      vim.cmd("startinsert")
    end
  end,
})

-- JANITOR
local function is_buffer_empty(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  return #lines == 1 and #lines[1] == 0
end

local function is_buffer_loaded_in_window(bufnr)
  local windows = vim.api.nvim_list_wins()
  for _, win in pairs(windows) do
    if (vim.api.nvim_win_get_buf(win) == bufnr) then return true end
  end
  return false
end

local function delete_empty()
  if vim.bo.filetype ~= 'starter' then
    local current_bufnr = vim.api.nvim_get_current_buf()
    local empty_buffers = {}

    -- Iterate through all buffers
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      -- Check if buffer is empty and not the current buffer
      if is_buffer_empty(bufnr) and not is_buffer_loaded_in_window(bufnr) and bufnr ~= current_bufnr then
        table.insert(empty_buffers, bufnr)
      end
    end

    -- Close all empty buffers
    for _, bufnr in ipairs(empty_buffers) do
      require('mini.bufremove').delete(bufnr, true)
      -- vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end
end

local janitor_group = vim.api.nvim_create_augroup("Janitor", { clear = true })

-- vim.api.nvim_create_autocmd({ "BufUnload" }, {
--   callback = delete_empty,
--   group = janitor_group,
-- })
-- vim.api.nvim_create_autocmd({ "BufWinLeave" }, {
--   callback = delete_empty,
--   group = janitor_group,
-- })




-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--   callback = function()
--     -- if vim.bo.fyletype ~= 'TelescopePrompt' then
--       local function is_buffer_empty(bufnr)
--         local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
--         return #lines == 1 and #lines[1] == 0
--       end
--
--       local current_bufnr = vim.api.nvim_get_current_buf()
--       local empty_buffers = {}
--
--       -- Iterate through all buffers
--       for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
--         -- Check if buffer is empty and not the current buffer
--         if is_buffer_empty(bufnr) and bufnr ~= current_bufnr then
--           table.insert(empty_buffers, bufnr)
--         end
--       end
--
--       -- Close all empty buffers
--       for _, bufnr in ipairs(empty_buffers) do
--         vim.api.nvim_buf_delete(bufnr, { force = true })
--       end
--     -- end
--   end,
--   group = janitor_group,
-- })
