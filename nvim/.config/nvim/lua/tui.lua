vim.o.cmdheight = 1
vim.o.showcmd = true
vim.o.showcmdloc = "statusline"
vim.o.laststatus = 3

local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
  ["nt"] = "UNFOCUSED TERMINAL",
}

local function mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
  local current_mode = vim.api.nvim_get_mode().mode
  local mode_color = "%#StatusLineAccent#"
  if current_mode == "n" then
    mode_color = "%#StatuslineAccent#"
  elseif current_mode == "i" or current_mode == "ic" then
    mode_color = "%#StatuslineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
    mode_color = "%#StatuslineVisualAccent#"
  elseif current_mode == "R" then
    mode_color = "%#StatuslineReplaceAccent#"
  elseif current_mode == "c" then
    mode_color = "%#StatuslineCmdLineAccent#"
  elseif current_mode == "t" then
    mode_color = "%#StatuslineTerminalAccent#"
  elseif current_mode == "nt" then
    mode_color = "%#StatuslineTerminalAccent#"
  end
  return mode_color
end

-- local function update_mode_colors()
--   local current_mode = vim.api.nvim_get_mode().mode
--   local mode_color = "%#StatusLineAccent#"
--   if current_mode == "n" then
--       mode_color = "%#StatuslineAccent#"
--   elseif current_mode == "i" or current_mode == "ic" then
--       mode_color = "%#StatuslineInsertAccent#"
--   elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
--       mode_color = "%#StatuslineVisualAccent#"
--   elseif current_mode == "R" then
--       mode_color = "%#StatuslineReplaceAccent#"
--   elseif current_mode == "c" then
--       mode_color = "%#StatuslineCmdLineAccent#"
--   elseif current_mode == "t" then
--       mode_color = "%#StatuslineTerminalAccent#"
--   end
--   return mode_color
-- end

local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
    return " "
  end

  return string.format(" %%<%s/", fpath)
end

local function filename()
  local fname = vim.fn.expand "%:t"
  if fname == "" then
    return ""
  end
  return fname .. " %m "
end

-- Function to execute shell commands
local function execute(command)
  local handle = io.popen(command)
  local result = handle:read("*a")
  handle:close()
  return result
end

-- Function to get the current Git branch
local function git_branch()
  local branch = execute(string.format("git -C %s rev-parse --abbrev-ref HEAD 2> /dev/null || echo ''", vim.fn.expand("%:h")))
  return branch:gsub("^%s*(.-)%s*$", "%1")=="" and "" or branch:gsub("^%s*(.-)%s*$", "<< %1>>") -- Trim whitespace
end

function Testee()
  vim.print(git_branch())
end

local function lsp()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = " %#LspDiagnosticsSignError# " .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = " %#LspDiagnosticsSignWarning# " .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = " %#LspDiagnosticsSignHint# " .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = " %#LspDiagnosticsSignInformation# " .. count["info"]
  end

  return errors .. warnings .. hints .. info .. "%#Normal#"
end

local function filetype()
  local icon, color = require('nvim-web-devicons').get_icon_color(filename(), vim.bo.filetype)
  vim.api.nvim_set_hl(0, 'StatusLineFileType', { foreground = color, background = 'none', bold = false })

  return string.format(" %%#StatusLineFileType#%s %s %%#Normal#", icon or "", vim.bo.filetype) --:upper()
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P %4.l:%3.c "
end

Statusline = {}

Statusline.active = function()
  return table.concat {
    "%#Statusline#",
    update_mode_colors(),
    mode(),
    "%#Normal#",
    filepath(),
    filename(),
    -- vim.api.nvim_get_mode().mode,
    -- "%#Directory# ",
    "%=%#WarningMsg#",
    git_branch(),
    "%=%#Normal#",
    lsp(),
    " ",
    filetype(),
    "%#StatusLineExtra#",
    lineinfo(),
  }
end

function Statusline.inactive()
  return " %F"
end

function Statusline.short()
  return "%#StatusLineNC#   NvimTree"
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)

-- vim.o.statusline = "%t%M %S%=%y %(%L lines %l:%c [%3.p%%]%)"

--statusline
-- vim.api.nvim_set_hl(0, 'StatusType',{ foreground='#1d2021', background='#b16286', bold=false })
-- vim.api.nvim_set_hl(0, 'StatusFile',{ foreground='#1d2021', background='#fabd2f', bold=false })
-- vim.api.nvim_set_hl(0, 'StatusModified',{ foreground='#d3869b', background='#1d2021', bold=false })
-- vim.api.nvim_set_hl(0, 'StatusBuffer',{ foreground='#1d2021', background='#98971a', bold=false })
-- vim.api.nvim_set_hl(0, 'StatusLocation',{ foreground='#1d2021', background='#458588', bold=false })
-- vim.api.nvim_set_hl(0, 'StatusPercent',{ foreground='#ebdbb2', background='#1d2021', bold=false })
-- vim.api.nvim_set_hl(0, 'StatusNorm',{ foreground='#FFFFFF', background='none', bold=false })
vim.api.nvim_set_hl(0, 'StatusType', { foreground = '#1d2021', background = '#b16286', bold = false })
vim.api.nvim_set_hl(0, 'StatusFile', { foreground = '#1d2021', background = '#fabd2f', bold = false })
vim.api.nvim_set_hl(0, 'StatusModified', { foreground = '#d3869b', background = '#1d2021', bold = false })
vim.api.nvim_set_hl(0, 'StatusBuffer', { foreground = '#1d2021', background = '#98971a', bold = false })
vim.api.nvim_set_hl(0, 'StatusLocation', { foreground = '#1d2021', background = '#458588', bold = false })
vim.api.nvim_set_hl(0, 'StatusPercent', { foreground = '#ebdbb2', background = '#1d2021', bold = false })
vim.api.nvim_set_hl(0, 'StatusNorm', { foreground = '#FFFFFF', background = 'none', bold = false })

local function getColor(group)
  return vim.api.nvim_get_hl_by_name(group, true)
end

vim.api.nvim_set_hl(0, 'StatusLineAccent', { foreground = '#000000', background = '#FFFFFF', bold = false })
vim.api.nvim_set_hl(0, 'StatuslineAccent',
  { foreground = '#000000', background = getColor('IncSearch').background, bold = false })
vim.api.nvim_set_hl(0, 'StatuslineInsertAccent',
  { foreground = '#000000', background = getColor('WarningMsg').foreground, bold = false })
vim.api.nvim_set_hl(0, 'StatuslineVisualAccent', getColor('Substitute'))
vim.api.nvim_set_hl(0, 'StatuslineCmdLineAccent', getColor('WildMenu'))
vim.api.nvim_set_hl(0, 'StatuslineTerminalAccent', getColor('DiffChange'))
vim.api.nvim_set_hl(0, 'StatuslineReplaceAccent', getColor('DiffText'))

-- vim.api.nvim_set_hl(0, 'StatusLineAccent',{ foreground='#000000', background='#FFFFFF', bold=false })
-- vim.api.nvim_set_hl(0, 'StatuslineAccent',{ foreground='#000000', background='#33bb77', bold=false })
-- vim.api.nvim_set_hl(0, 'StatuslineInsertAccent',{ foreground='#000000', background='#00AF21', bold=false })
-- vim.api.nvim_set_hl(0, 'StatuslineVisualAccent',{ foreground='#000000', background='#FF4321', bold=false })
-- vim.api.nvim_set_hl(0, 'StatuslineReplaceAccent',{ foreground='#000000', background='#FFFFFF', bold=false })
-- vim.api.nvim_set_hl(0, 'StatuslineCmdLineAccent',{ foreground='#000000', background='#3377EB', bold=false })
-- vim.api.nvim_set_hl(0, 'StatuslineTerminalAccent',{ foreground='#000000', background='#1274AF', bold=false })

vim.api.nvim_set_hl(0, 'StatusGit', { foreground = '#AA23FF', background = 'none', bold = false })

vim.api.nvim_set_hl(0, 'LspDiagnosticsSignError', { foreground = '#FF4321', background = 'none', bold = false })
vim.api.nvim_set_hl(0, 'LspDiagnosticsSignWarning', { foreground = '#AA8710', background = 'none', bold = false })
vim.api.nvim_set_hl(0, 'LspDiagnosticsSignHint', { foreground = '#1274AF', background = 'none', bold = false })
vim.api.nvim_set_hl(0, 'LspDiagnosticsSignInformation', { foreground = '#00AF21', background = 'none', bold = false })

-- vim.o.statusline = " "
-- 				.. ""
-- 				.. " "
-- 				.. "%l"
-- 				.. " "
-- 				.. " %#StatusType#"
-- 				.. "  "
-- 				.. "%#StatusFile#"
-- 				.. "%F"
-- 				.. "%#StatusModified#"
-- 				.. " "
-- 				.. "%m"
-- 				.. " "
-- 				.. "%#StatusNorm#"
-- 				.. "%="
-- 				.. "%#StatusBuffer#"
-- 				.. "﬘ "
-- 				.. "%n"
-- 				.. "%#StatusLocation#"
-- 				.. "燐 "
-- 				.. "%l,%c"
-- 				.. "%#StatusPercent#"
-- 				.. "%p%%  "


-- vim.o.showtabline = 2

return {}
