local function append_multiline(lines, position)
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, position, position, false, lines)
end

local function remove_line_from_buffer(line_number)
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_lines(buf, line_number - 1, line_number, false, {})
end

local function cpp_mangling_prevention_mechanism()
  return "#ifdef __cplusplus\r"
      .. "extern \"C\" {\r"
      .. "#endif//__cplusplus\r\r\r\r"
      .. "#ifdef __cplusplus\r"
      .. "}\r"
      .. "#endif//__cplusplus\r"
end

local function c_header_guard(name)
  return "#ifndef __" .. name .. "_H__\r"
      .. "#define __" .. name .. "_H__\r"
      .. cpp_mangling_prevention_mechanism()
      .. "#endif//__" .. name .. "_H__\r"
      .. "\r"
end

local function c_header_only_imp(name)
  return "//#define " .. name .. "_IMPLEMENTATIONS\r"
      .. "#ifdef " .. name .. "_IMPLEMENTATIONS\r"
      .. "#ifndef __" .. name .. "_IMP__\r"
      .. "#define __" .. name .. "_IMP__\r"
      .. cpp_mangling_prevention_mechanism()
      .. "#endif//__" .. name .. "_IMP__\r"
      .. "#undef ".. name .. "_IMPLEMENTATIONS\r"
      .. "#endif//" .. name .. "_IMPLEMENTATIONS\r"
      .. "\r"
end

local function generate_c_header_only_preprocs()
  local linen = vim.fn.line('.')
  local line_content = vim.fn.getline(linen)
  local filepath = vim.api.nvim_buf_get_name(0)
  local filename = vim.fn.fnamemodify(filepath, ":t:r")
  local h_name = filename:upper()

  local preproc_thing = c_header_guard(h_name) .. c_header_only_imp(h_name)

  local lines = vim.split(preproc_thing, "\r")

  while '' == lines[1] do table.remove(lines, 1) end
  if lines[#lines] == "" then table.remove(lines, #lines) end

  append_multiline(lines, linen)
  if line_content == '' or line_content == '\r' then
    remove_line_from_buffer(linen)
  end
end

vim.api.nvim_create_user_command('CHeaderThing', generate_c_header_only_preprocs, { desc = 'Execute command in place' })
require('which-key').add({ '<leader>L', desc = "Source" })
vim.keymap.set({ 'n' }, '<leader>Ll', ':source %<CR>', { desc = 'Source current file' })
vim.keymap.set({ 'n' }, '<leader>LL', ':source ~/.config/nvim/init.lua<CR>', { desc = 'Source global config' })
