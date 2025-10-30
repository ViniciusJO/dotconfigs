-- vim.api.nvim_create_user_command("GrepInDirectory", require("telescope").extensions.dir.live_grep, {})
-- vim.api.nvim_create_user_command("FileInDirectory", require("telescope").extensions.dir.find_files, {})
--

local function append_multiline(lines, position)
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, position, position, false, lines)
end

local function append_multiline_indent(lines, position, indent)
  local padding = ""
  for _ = 1, indent, 1 do padding = padding .. " " end

  local indented_lines = {}
  for _, line in ipairs(lines) do
    table.insert(indented_lines, padding .. line)
  end

  append_multiline(indented_lines, position)
end

local function remove_line_from_buffer(line_number)
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, line_number - 1, line_number, false, {})
end

local function count_leading_spaces(str)
  local count = 0
  for i = 1, #str do
    if str:sub(i, i) == " " then
      count = count + 1
    else
      break
    end
  end
  return count
end

-- local function get_comment_marker(filetype)
--   local clients = vim.lsp.get_active_clients()
--
--   for _, client in ipairs(clients) do
--     if client.supports_method("textDocument/completion") then
--       local comment_marker = client.resolved_capabilities.document_formatting
--       if comment_marker and comment_marker[filetype] then
--         return comment_marker[filetype]
--       end
--     end
--   end
--
--   return nil   -- Return nil if no comment marker is found
-- end


-- TODO:
--    - Remove comment markers to allow to execute commands inside comments (lsp integration)
--    - Highlight with treesitter the commands inside comments
local function executeCommandInBuffer(replace)
  return function()
    local linen = vim.fn.line('.')
    local line_content = vim.fn.getline(linen)

    -- local filetype = vim.bo.filetype
    -- local marker = get_comment_marker(filetype)
    -- print(marker)
    local command = line_content:gsub("^%s*", "")
    if nil == command:find("^:") and nil == command:find("^!") then
      vim.notify('\"' .. command .. '\" is not a valid command', vim.log.levels.ERROR)
      return
    end
    local result = vim.api.nvim_exec2(command, { output = true }).output
        :gsub("\0", "")
        :gsub(string.char(10), "\r")
        :gsub("%z", "")
        :gsub("^:*" .. command:gsub("^:", ""), "")
    local lines = vim.split(result, "\r")

    if lines[1] == command:gsub("^!", ":!") then table.remove(lines, 1) end
    while '' == lines[1] do table.remove(lines, 1) end
    if lines[#lines] == "" then table.remove(lines, #lines) end

    append_multiline_indent(lines, linen, count_leading_spaces(line_content))
    if replace then
      remove_line_from_buffer(linen)
    end
    --[[
    !printf "a\n"

    --]]
  end
end

vim.keymap.set({ 'n' }, '<C-x>', executeCommandInBuffer(false), { desc = 'Execute command in place' })
vim.keymap.set({ 'n' }, '<M-x>', executeCommandInBuffer(true), { desc = 'Execute command in place and replace' })

-- Function to print the ASCII code of the character under the cursor
local function print_char_code()
  -- Get the cursor position
  local line_number = vim.fn.line('.')
  local column_number = vim.fn.col('.')

  -- Get the content of the current line
  local line_content = vim.fn.getline(line_number)

  -- Get the character under the cursor
  local char = line_content:sub(column_number, column_number)

  -- Print the ASCII code of the character
  local char_code = string.byte(char)
  print("Character code: '" .. char .. "' = " .. char_code)
end

-- Create a key mapping to call the function
vim.keymap.set('n', '<leader>A', print_char_code, { desc = 'Code of char under cursor', noremap = true, silent = true })

local function preprocessCFile()
  -- Get the current buffer's file name
  local current_file = vim.fn.expand('%:p')

  -- Check if the current file is a C file
  if not current_file:match('%.c$') and not current_file:match('%.h$') then
    print("Not a C or header file")
    return
  end

  -- Preprocess the C file
  -- vim.print("Preprocessing...");
  vim.notify("Preprocessing...", vim.log.levels.INFO, { title = "PreprocessCFile" })
  local output = vim.fn.system("make --quiet preprocess filename=" ..
    current_file .. ' 2>&1 | grep --invert-match "^#" | clang-format | sed \'/./,/^$/!d; /^$/N;/\\n$/D\'')
  -- vim.notify("Done.", vim.log.levels.INFO, { title = "PreprocessCFile" })

  -- Create a new buffer
  vim.cmd('new')        -- Open a new buffer
  vim.bo.filetype = 'c' -- Set filetype to C

  -- Insert the output into the new buffer
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(output, "\n"))
  vim.cmd('setlocal buftype=nofile') -- Set buffer as not a file
end

vim.api.nvim_create_user_command('PreprocessC', preprocessCFile, {})
vim.keymap.set('n', '<leader>lp', preprocessCFile, { desc = 'Preprocess C File' })
