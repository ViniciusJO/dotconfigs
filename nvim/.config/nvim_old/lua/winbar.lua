

local bufnr1 = vim.api.nvim_get_current_buf()
-- vim.print(require('nvim-navic').get_data(bufnr1))


-- TODO: fix winbar
function CreateWinbar()
  if vim.bo.filetype == "neo-tree" or vim.bo.filetype == "TelescopePrompt" then
    return
  end
  vim.print(vim.bo.filetype)

  local bufnr = vim.bo.nvim_get_current_buf()
  local text = "%#Normal#%f"

  for _, context in ipairs(require('nvim-navic').get_data(bufnr) or {}) do
    text = text .. (text == "%#Normal#" and "" or " > ") .. context.icon .. " " .. context.name
  end

  vim.o.winbar = text
  return text
end

-- vim.print(CreateWinbar())

-- vim.o.winbar = "%!v:lua.CreateWinbar(lua.vim.api.nvim_get_current_buf())"

-- Action on enter
local winbar_group = vim.api.nvim_create_augroup("ActionOnEnter", { clear = true })
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = CreateWinbar,
  group = winbar_group,
})

local function aaa()
  local function clke_()
    print("OLA")
  end
  return function ()
    print("Hello")
    clke_()
  end
end

-- local bufnr = vim.api.nvim_get_current_buf()
-- -- vim.print(vim.api)
--
-- local function printKeys(_table)
  --   for i, _ in pairs(_table) do
  --     vim.print(i)
  --   end
  -- end
  --
  --
  -- local params = vim.lsp.util.make_position_params()
--
-- vim.lsp.buf_request(0, 'textDocument/documentSymbol', params, 
--   function(err, _, result)
--     if err then
--         print('Error:', err)
--         return
--     end
--
--     if not result or vim.tbl_isempty(result) then
--         print('No symbols found')
--         return
--     end
--
--     -- Find the function where the cursor is located
--     local cursor_pos = vim.api.nvim_win_get_cursor(0)
--     local line = cursor_pos[1] - 1
--     local character = cursor_pos[2]
--
--     local function_name = nil
--
--     vim.print(result)
--     for _, symbol in ipairs(result) do
--       vim.print(symbol)
--         if ((symbol.kind == 3) and (symbol.range.start.line <= line) and (symbol.range["end"].line >= line)) then
--             for _, child_symbol in ipairs(symbol.children or {}) do
--                 if child_symbol.kind == 2 and child_symbol.range.start.line <= line and child_symbol.range["end"].line >= line and child_symbol.range.start.character <= character and child_symbol.range["end"].character >= character then
--                     function_name = child_symbol.name
--                     break
--                 end
--             end
--             if function_name then
--                 break
--             end
--         end
--     end
--
--     if function_name then
--         print('Cursor is in function:', function_name)
--     else
--         print('Cursor is not in a function')
--     end
--   end
-- )

-- printKeys(vim.api.nvim_get_context({ types = {  } }))
-- printKeys(vim.api)
-- for i, _ in pairs(vim.api.nvim_get_context({ types = {  } })) do
--   vim.print(i.."\n")
-- end
-- function get_data(bufnr)
--
-- 	bufnr = bufnr or vim.api.nvim_get_current_buf()
-- 	local context_data = lib.get_context_data(bufnr)
--
-- 	if context_data == nil then
-- 		return nil
-- 	end
--
-- 	local ret = {}
--
-- 	for i, v in ipairs(context_data) do
-- 		if i ~= 1 then
-- 			table.insert(ret, {
-- 				kind = v.kind,
-- 				type = lib.adapt_lsp_num_to_str(v.kind),
-- 				name = v.name,
-- 				icon = config.icons[v.kind],
-- 				scope = v.scope,
-- 			})
-- 		end
-- 	end
--
-- 	return ret
-- end
--
-- function format_data(data, opts)
-- 	if data == nil then
-- 		return ""
-- 	end
--
-- 	local local_config = {}
--
-- 	if opts ~= nil then
-- 		local_config = vim.deepcopy(config)
--
-- 		if opts.icons ~= nil then
-- 			for k, v in pairs(opts.icons) do
-- 				if lib.adapt_lsp_str_to_num(k) then
-- 					local_config.icons[lib.adapt_lsp_str_to_num(k)] = v
-- 				end
-- 			end
-- 		end
--
-- 		if opts.separator ~= nil then
-- 			local_config.separator = opts.separator
-- 		end
-- 		if opts.depth_limit ~= nil then
-- 			local_config.depth_limit = opts.depth_limit
-- 		end
-- 		if opts.depth_limit_indicator ~= nil then
-- 			local_config.depth_limit_indicator = opts.depth_limit_indicator
-- 		end
-- 		if opts.highlight ~= nil then
-- 			local_config.highlight = opts.highlight
-- 		end
-- 		if opts.safe_output ~= nil then
-- 			local_config.safe_output = opts.safe_output
-- 		end
-- 		if opts.click ~= nil then
-- 			local_config.click = opts.click
-- 		end
-- 	else
-- 		local_config = config
-- 	end
--
--
-- 	local location = {}
--
-- 	local function add_hl(kind, name)
-- 		return "%#NavicIcons"
-- 			.. lib.adapt_lsp_num_to_str(kind)
-- 			.. "#"
-- 			.. local_config.icons[kind]
-- 			.. "%*%#NavicText#"
-- 			.. config.format_text(name)
-- 			.. "%*"
-- 	end
--
-- 	if local_config.click then
-- 		_G.navic_click_handler = function(minwid, cnt, _, _)
-- 			vim.cmd("normal! m'")
-- 			vim.api.nvim_win_set_cursor(0, {
-- 				data[minwid].scope["start"].line,
-- 				data[minwid].scope["start"].character
-- 			})
-- 			if cnt > 1 then
-- 				local ok, navbuddy = pcall(require, "nvim-navbuddy")
-- 				if ok then
-- 					navbuddy.open(bufnr)
-- 				else
-- 					vim.notify("nvim-navic: Double click requires nvim-navbuddy to be installed.", vim.log.levels.WARN)
-- 				end
-- 			end
-- 		end
-- 	end
--
-- 	local function add_click(level, component)
-- 		return "%"
-- 			.. level
-- 			.. "@v:lua.navic_click_handler@"
-- 			.. component
-- 			.. "%X"
-- 	end
--
-- 	for i, v in ipairs(data) do
-- 		local name = ""
--
-- 		if local_config.safe_output then
-- 			name = string.gsub(v.name, "%%", "%%%%")
-- 			name = string.gsub(name, "\n", " ")
-- 		else
-- 			name = v.name
-- 		end
--
-- 		local component
--
-- 		if local_config.highlight then
-- 			component = add_hl(v.kind, name)
-- 		else
-- 			component = v.icon .. name
-- 		end
--
-- 		if local_config.click then
-- 			component = add_click(i, component)
-- 		end
--
-- 		table.insert(location, component)
-- 	end
--
-- 	if local_config.depth_limit ~= 0 and #location > local_config.depth_limit then
-- 		location = vim.list_slice(location, #location - local_config.depth_limit + 1, #location)
-- 		if local_config.highlight then
-- 			table.insert(location, 1, "%#NavicSeparator#" .. local_config.depth_limit_indicator .. "%*")
-- 		else
-- 			table.insert(location, 1, local_config.depth_limit_indicator)
-- 		end
-- 	end
--
-- 	local ret = ""
--
-- 	if local_config.highlight then
-- 		ret = table.concat(location, "%#NavicSeparator#" .. local_config.separator .. "%*")
-- 	else
-- 		ret = table.concat(location, local_config.separator)
-- 	end
--
-- 	return ret
-- end
