local M = {}

local ns = vim.api.nvim_create_namespace("my-ui")

local messages = {}

local win, buf

M.cursor = 0

local function serialize(o)
    if type(o) == "number" or type(o) == "boolean" then
        return tostring(o)
    elseif type(o) == "string" then
        return o -- %q safely formats strings with quotes/escapes
    elseif type(o) == "table" then
        local buffer = "{\n"
        -- for k, v in pairs(o) do
        for _, v in pairs(o) do
            -- Keys that are strings need quotes
            -- if type(k) == "string" then
            --     buffer = buffer .. '  ["' .. k .. '"] = '
            -- else
            --     buffer = buffer .. '  [' .. k .. '] = '
            -- end
            buffer = buffer .. serialize(v) .. ",\n"
        end
        buffer = buffer .. "}"
        return buffer
    else
        error("Cannot serialize type: " .. type(o))
    end
end

local function splitByNewline(str)
    local lines = {}
    -- Normalize line endings to '\n'
    str = str:gsub("\r\n", "\n")
    -- Ensure the string ends with a newline to catch the last line
    if str:sub(-1) ~= "\n" then
        str = str .. "\n"
    end

    -- Use gmatch to find lines
    -- (.-) matches the shortest sequence of characters until the next \n
    for line in str:gmatch("(.-)\n") do
        table.insert(lines, line)
    end
    return lines
end

vim.api.nvim_set_hl(0, "FloatBorderTransparent", {
  bg = "NONE",
  fg = "NONE",
})

vim.api.nvim_set_hl(0, "FloatTransparent", {
  bg = "NONE",
})

local function schedule_win_close(window, timeout)
  vim.defer_fn(function()
    if window and vim.api.nvim_win_is_valid(window) then
      vim.api.nvim_win_close(window, true)
    end
  end, timeout)
end

local function open_window(w, h, timeout)
  if win and vim.api.nvim_win_is_valid(win) then
    -- return
    vim.api.nvim_win_close(win, true)
  end

  buf = vim.api.nvim_create_buf(false, true)

  -- local w = math.floor(vim.o.columns * 0.25);
  -- local h = math.floor(vim.o.lines * 0.25);

  win = vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    width = w,
    height = h,
    row = 1, -- vim.o.lines - h - 3,
    col = vim.o.columns - w - 3,
    style = "minimal",
    border = "none",
  })

  vim.api.nvim_win_set_option(win, "winhl",
    "Normal:FloatTransparent,NormalNC:FloatTransparent,FloatBorder:FloatBorderTransparent"
  )

  if timeout > 0 then
    schedule_win_close(win, timeout)
  end
end

local function padding(n)
  local r = ""
  for _ = 1,n,1 do
    r = r .. " "
  end
  return r
end

--- Render image in floating window
---@param value any -- value to put on output buffer
---@param bottom_up boolean? -- wheter to start rendering from the bottom of the buffer
---@param right_align boolean? -- wheter to align to the right corner
---@param timeout integer? -- time to kill output window
local function render(value, bottom_up, right_align, timeout)
  local content = splitByNewline(serialize(value));

  local w = 0
  local h = #content

  for i = 1, h, 1 do
    local l = string.len(content[i]);
    w = l > w and l or w
  end

  open_window(w+1, h+1, timeout or 0)

  if bottom_up then
    for i = 1, h, 1 do
      vim.api.nvim_buf_set_lines(buf, h-i-1, h-i-1, false, { padding(right_align and w-string.len(content[i]) or 0)..content[i] })
    end
  else
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, content)
  end

end

M.cmdline = {
  active = false,
  text = "",
  pos = 0,
  level = 0,
  firstc = "",
}

function M.attach()
  vim.ui_attach(ns, { ext_messages = true }, function(event, ...)
    if event == "msg_show" then

      -- local args = {...}
      -- local chunks = 
      -- local kind, chunks = ...
      local _, chunks = ...
      --
      -- local line = ""
      -- local c = {}
      --
      -- for _, chunk in ipairs(chunks) do
      --   -- line = line .. chunk[1]
      --   local text = chunk[1]
      --   local hlg = chunk[2]
      --   table.insert(c, text)
      -- end

      -- table.insert(messages, line)
      -- local _args = {...};
      vim.schedule(function()
        -- local r = table.concat(args, "\n");
        -- local s = {};
        -- for _, v in ipairs(_args) do
        --   if type(v) == "table" then
        --     for idx, vi in ipairs(splitByNewline(serialize(v))) do
        --       table.insert(s, idx..tostring(vi))
        --     end
        --   else
        --     table.insert(s, tostring(v))
        --   end
        -- end
        -- render(s)
        -- render(splitByNewline(serialize(args)))
        -- render(splitByNewline(serialize(_args)))
        local content = chunks[1][2];
        render(content, true, false, 2000)
        -- render(splitByNewline(vim.json.encode(args)))
        -- render(args)
      end)

    elseif event == "msg_history_show" then
      local entries = ...
      -- messages = {}
      --
      -- for _, entry in ipairs(entries) do
      --   local line = ""
      --   for _, chunk in ipairs(entry) do
      --     line = line .. chunk[1]
      --   end
      --   table.insert(messages, line)
      -- end

      vim.schedule(function() render(entries, false, false) end)
    elseif event == "msg_clear" then
      messages = {};
      vim.schedule(function() render(messages, false, false, 2000) end)
      if event == "cmdline_show" then
        local content, pos, firstc, prompt, indent, level = ...

        M.cmdline.active = true
        M.cmdline.level = level
        M.cmdline.firstc = firstc
        M.cmdline.pos = pos

        -- flatten content
        local s = ""
        for _, chunk in ipairs(content) do
          s = s .. chunk[1]
        end
        M.cmdline.text = s

      elseif event == "cmdline_pos" then
        local pos, level = ...
        vim.schedule(function() render({ pos = pos }, false, false) end)
        if level == M.cmdline.level then
          M.cmdline.pos = pos
        end

      elseif event == "cmdline_hide" then
        local level = ...
        if level == M.cmdline.level then
          M.cmdline.active = false
        end
      end
    -- else
    --   local entries = { ... }
    --   table.insert(entries, { event })
    --   vim.schedule(function() render(entries, false, false, 2000) end)
    end

    return true
  end)
end

--- render the highlight on cursor position inside s
---@param s string
---@return string
function M.place_cursor(s)
  print(s)
  return (string.sub(s, 1, M.cmdline.pos+1) or "") .. "%=%#WarningMsg#" .. (s[M.cmdline.pos+1] or ".") .. "%=%#Normal#" .. (string.sub(s, M.cmdline.pos+2) or "")
end

-- M.attach()

return M
