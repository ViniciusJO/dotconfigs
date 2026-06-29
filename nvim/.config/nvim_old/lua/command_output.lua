-- msg_float.lua
-- Minimal UI-level message interceptor that renders :messages in a float

local M = {}

-- ── State ──────────────────────────────────────────────────────────────
local buf = nil
local win = nil
local lines = {}
local attached = false

-- ── Floating window management ─────────────────────────────────────────
local function ensure_window()
  if win and vim.api.nvim_win_is_valid(win) then
    return
  end

  buf = vim.api.nvim_create_buf(true, true)

  local width  = math.floor(vim.o.columns * 0.35)
  local height = math.floor(vim.o.lines * 0.25)

  win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    anchor = "SE",
    row = vim.o.lines - 1,
    col = vim.o.columns,
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
    focusable = true,
  })

  -- vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].filetype = "messages"
end

-- ── Helpers ─────────────────────────────────────────────────────────────
local function chunks_to_lines(chunks)
  local text = {}
  for _, chunk in ipairs(chunks or {}) do
    table.insert(text, chunk[1])
  end

  local joined = table.concat(text)
  local out = {}

  for line in joined:gmatch("[^\n]+") do
    table.insert(out, line)
  end

  return out
end

local function append(new_lines)
  if not new_lines or #new_lines == 0 then
    return
  end

  ensure_window()

  for _, l in ipairs(new_lines) do
    table.insert(lines, l)
  end

  -- limit history (like :messages)
  local max = 500
  if #lines > max then
    lines = vim.list_slice(lines, #lines - max + 1)
  end

  if (not buf) or (not win) then return end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_win_set_cursor(win, { #lines, 0 })
end

-- ── UI attach ───────────────────────────────────────────────────────────
function M.attach()
  if attached then
    return
  end
  attached = true
  local ns = vim.api.nvim_create_namespace('my_fancy_pum')
  vim.ui_attach(ns, { ext_messages = true, }, function(event, args)
    if event == "msg_show" then
      vim.schedule(function()
        append(chunks_to_lines(args.content))
      end)

    elseif event == "msg_history_show" then
      vim.schedule(function()
        for _, msg in ipairs(args.entries or {}) do
          local ctl = chunks_to_lines(msg.content);
          append(ctl);
          local bufnr = vim.api.nvim_get_current_buf();
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, ctl);
        end
      end)

    elseif event == "msg_clear" then
      -- intentionally ignored (matches :messages behavior)
    end
  end)
end

-- ── Optional helpers ────────────────────────────────────────────────────
function M.clear()
  lines = {}
  if buf and vim.api.nvim_buf_is_valid(buf) then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
  end
end

function M.toggle()
  if win and vim.api.nvim_win_is_valid(win) then
    vim.api.nvim_win_close(win, true)
    win = nil
  else
    ensure_window()
  end
end

vim.keymap.set("n", "<leader>o", function()
  M.toggle()
end)

return M


-- local M = {}
--
-- M.buf = nil
-- M.win = nil
-- M.lines = {}
--
-- local function open_float()
--   if M.win and vim.api.nvim_win_is_valid(M.win) then
--     return
--   end
--
--   M.buf = vim.api.nvim_create_buf(false, true)
--
--   local width = math.floor(vim.o.columns * 0.4)
--   local height = math.floor(vim.o.lines * 0.25)
--
--   M.win = vim.api.nvim_open_win(M.buf, false, {
--     relative = "editor",
--     anchor = "SE",
--     row = vim.o.lines - 1,
--     col = vim.o.columns,
--     width = width,
--     height = height,
--     style = "minimal",
--     border = "rounded",
--   })
-- end
--
-- local function append(lines)
--   open_float()
--   vim.list_extend(M.lines, lines)
--   vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, M.lines)
-- end
--
-- vim.api.nvim_create_autocmd("MsgShow", {
--   callback = function(ev)
--     -- ev.msg is a list of chunks { {text, hl}, ... }
--     local out = {}
--
--     for _, chunk in ipairs(ev.msg) do
--       table.insert(out, chunk[1])
--     end
--
--     if #out > 0 then
--       append(out)
--     end
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("MsgClear", {
--   callback = function()
--     M.lines = {}
--     if M.buf and vim.api.nvim_buf_is_valid(M.buf) then
--       vim.api.nvim_buf_set_lines(M.buf, 0, -1, false, {})
--     end
--   end,
-- })
--
--
--
-- return M
