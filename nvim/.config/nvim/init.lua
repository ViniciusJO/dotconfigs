vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.loader.enable()

require 'options'
require 'aucmd'
require 'plugins'
require 'keymaps'
require 'commands'
require 'colorscheme'
require 'tui'

require 'c_things'

-- require('command_output').attach();

vim.filetype.add({
  extension = {
    yml = 'yaml.ansible'
  }
})

require 'custom'

require('vitest').init()

local function file_exists(path)
    return vim.uv.fs_stat(path) ~= nil
end

vim.api.nvim_create_user_command("TestAPICommand", function ()
  -- pnpm vitest --reporter json --isolate --silent run
  local c = vim.system({ "pnpm", "vitest", "--reporter", "json", "--isolate", "--silent", "run", "2> /dev/null", "|", "tail", "-n", "+4" }):wait().stdout
  if c then vim.print(vim.json.decode(c)) end
end, {})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "tex",
  callback = function()
    -- local config_path = vim.fn.stdpath("config")

    local mupdf = nil;
    local mupdf_updater = nil;

    local work_folder = ".worktex"

    vim.fn.system("mkdir -p "..work_folder)

    local buf = vim.api.nvim_get_current_buf()
    local file_path = vim.api.nvim_buf_get_name(buf)

    local dir = vim.fn.fnamemodify(file_path, ":h")  -- Obtém o diretório
    local filename = vim.fn.fnamemodify(file_path, ":t") -- Obtém apenas o nome do arquivo

    local work_folder_in_path = (work_folder ~= "" and (work_folder.."/") or "")
    local tmp_file = dir.."/"..work_folder_in_path..string.gsub(filename,".tex", "_live.tex")
    local diff_file = dir.."/"..work_folder_in_path..string.gsub(filename,".tex", "_preview.tex")
    local pdf_file = string.gsub(diff_file, "_preview.tex", "_preview.pdf")

    -- local mupdf_updater_cmd = "inotifywait -qmre close_write '"..work_folder_in_path.."' --format \"%w%f\" | while read -r f; do [[ \"$f\" == *_preview.tex ]] || continue; lualatex -synctex=on -interaction=nonstopmode -shell-escape -output-directory '"..work_folder_in_path.."' \"$f\"; [[ -f \"$f\" ]] && pkill -HUP mupdf; done"
    local diff_cmd = string.format("latexdiff -t UNDERLINE %s %s", vim.fn.shellescape(file_path), vim.fn.shellescape(tmp_file))

    local att_lock = false;
    -- local max_att_interval = 1000;

    vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufEnter", "BufWritePost" }, {
      pattern = "*",
      callback = function()
        if not att_lock then
          vim.fn.writefile(vim.api.nvim_buf_get_lines(buf, 1, -1, false), tmp_file)

          local diff_output = vim.fn.system(diff_cmd)

          if diff_output ~= "" then vim.fn.writefile(vim.split(diff_output, "\n"), diff_file) end

          -- vim.fn.system("lualatex -synctex=on -interaction=nonstopmode -shell-escape -output-directory='"..work_folder.."' "..diff_file.."; killall -HUP mupdf")
          -- vim.system({
          --   "xelatex",
          --     "-synctex=on",
          --     "-interaction=nonstopmode",
          --     "-shell-escape",
          --     -- "-output-directory='"..work_folder.."'",
          --     diff_file
          -- }, { text = true }, function()
            -- if mupdf then mupdf:kill(1); end -- "SIGHUP"
            -- vim.system({ "killall", "-HUP", "mupdf" }, { text = false });
            -- if mupdf then
              -- att_lock = true;
              -- vim.defer_fn(function()
                -- if mupdf then mupdf:kill(1); end -- "SIGHUP"
                -- while not file_exists(pdf_file) do end;
                -- vim.system({ "killall", "-HUP", "mupdf" }, { text = false });
                -- att_lock = false;
              -- end, max_att_interval);
          --   end
          -- end)
        end
      end,
    })

    vim.keymap.set("n", "<leader>p", function()
      if mupdf then
        -- print("Kill mupdf")
        mupdf:kill();
        mupdf = nil;
        if mupdf_updater then
          mupdf_updater:kill();
          mupdf_updater = nil;
        end
      else
        if not file_exists(pdf_file) then vim.cmd("w") end
        print("Open mupdf "..pdf_file)
        mupdf = vim.system({ "mupdf", pdf_file }, { text = true }, function(e)
          vim.print(e.stdout);
          vim.print(e.stderr);
          mupdf = nil;
        end)
        if mupdf_updater then
          mupdf_updater:kill()
          mupdf_updater = nil
        end
        print("start mupdf_updater");
        -- print(config_path)
        -- print(mupdf_updater_cmd)
        -- mupdf_updater = vim.system({
        --   ---@diagnostic disable-next-line: assign-type-mismatch
        --   config_path.."/latex_watch.sh",
        --   work_folder_in_path
        -- }, { text = true }, function(e)
        --   mupdf_updater = nil;
        --   print("================OUT===================")
        --   vim.print(e.stdout)
        --   print("===============ERROR==================")
        --   vim.print(e.stderr)
        -- end)
      end
    end, { noremap = true, silent = true, desc = "Preview PDF in mupdf" })


    vim.api.nvim_create_autocmd({ "VimLeave" }, {
      pattern = "*",
      callback = function()
        if mupdf then mupdf:kill(); end
        if mupdf_updater then mupdf_updater:kill(); end
      end
    })

  end,
})

-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = "typst",
--   callback = function()
--     -- local config_path = vim.fn.stdpath("config")
--
--     local mupdf = nil;
--     local mupdf_updater = nil;
--
--     local work_folder = ".worktyp"
--
--     vim.fn.system("mkdir -p "..work_folder)
--
--     local buf = vim.api.nvim_get_current_buf()
--     local file_path = vim.api.nvim_buf_get_name(buf)
--
--     local dir = vim.fn.fnamemodify(file_path, ":h")  -- Obtém o diretório
--     local filename = vim.fn.fnamemodify(file_path, ":t") -- Obtém apenas o nome do arquivo
--
--     local work_folder_in_path = (work_folder ~= "" and (work_folder.."/") or "")
--     local tmp_file = dir.."/"..work_folder_in_path..string.gsub(filename,".typ", "_live.typ")
--     local diff_file = dir.."/"..work_folder_in_path..string.gsub(filename,".typ", "_preview.typ")
--     local pdf_file = string.gsub(diff_file, "_preview.typ", "_preview.pdf")
--
--     -- local mupdf_updater_cmd = "inotifywait -qmre close_write '"..work_folder_in_path.."' --format \"%w%f\" | while read -r f; do [[ \"$f\" == *_preview.tex ]] || continue; lualatex -synctex=on -interaction=nonstopmode -shell-escape -output-directory '"..work_folder_in_path.."' \"$f\"; [[ -f \"$f\" ]] && pkill -HUP mupdf; done"
--     local diff_cmd = string.format(
--       'wdiff %s %s -w "#strike(text(fill: red)[" -x "])" -y "#text(fill: green)[" -z "]" | tee diff.typ',
--       vim.fn.shellescape(file_path),
--       vim.fn.shellescape(tmp_file)
--     )
--
--
--     local att_lock = false;
--     -- local max_att_interval = 1000;
--
--     vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI", "BufEnter", "BufWritePost" }, {
--       pattern = "*",
--       callback = function()
--         if not att_lock then
--           vim.fn.writefile(vim.api.nvim_buf_get_lines(buf, 1, -1, false), tmp_file)
--
--           local diff_output = vim.fn.system(diff_cmd)
--
--           if diff_output ~= "" then vim.fn.writefile(vim.split(diff_output, "\n"), diff_file) end
--         end
--       end,
--     })
--
--     vim.keymap.set("n", "<leader>p", function()
--       if mupdf then
--         -- print("Kill mupdf")
--         mupdf:kill();
--         mupdf = nil;
--         if mupdf_updater then
--           mupdf_updater:kill();
--           mupdf_updater = nil;
--         end
--       else
--         if not file_exists(pdf_file) then vim.cmd("w") end
--         print("Open mupdf "..pdf_file)
--         mupdf = vim.system({ "mupdf", pdf_file }, { text = true }, function(e)
--           vim.print(e.stdout);
--           vim.print(e.stderr);
--           mupdf = nil;
--         end)
--         if mupdf_updater then
--           mupdf_updater:kill()
--           mupdf_updater = nil
--         end
--         print("start mupdf_updater");
--
--         --f=.worktyp/t_preview.pdf; mupdf $f & while inotifywait -e close_write $f; do pkill -HUP mupdf; done & typst w .worktyp/t_preview.typ
--
--         -- print(config_path)
--         -- print(mupdf_updater_cmd)
--         -- mupdf_updater = vim.system({
--         --   ---@diagnostic disable-next-line: assign-type-mismatch
--         --   config_path.."/latex_watch.sh",
--         --   work_folder_in_path
--         -- }, { text = true }, function(e)
--         --   mupdf_updater = nil;
--         --   print("================OUT===================")
--         --   vim.print(e.stdout)
--         --   print("===============ERROR==================")
--         --   vim.print(e.stderr)
--         -- end)
--       end
--     end, { noremap = true, silent = true, desc = "Preview PDF in mupdf" })
--
--
--     vim.api.nvim_create_autocmd({ "VimLeave" }, {
--       pattern = "*",
--       callback = function()
--         if mupdf then mupdf:kill(); end
--         if mupdf_updater then mupdf_updater:kill(); end
--       end
--     })
--
--   end,
-- })


-- require 'nvim-llama'.setup()
--require('my-plugin')

--[[
local pattern = '\'.*\''
local bufnr = vim.fn.bufnr()
local query = vim.fn.getreg("/") -- Get the last search pattern (regex) from the search register
local root = vim.treesitter.get_parser(bufnr, vim.bo.filetype):parse()[1]:root()
for match in vim.treesitter.query(bufnr, pattern):iter_matches(root, bufnr, 0, -1) do
	print(match.node:range())
	local start_row, start_col, end_row, end_col = match.node:range()
	vim.fn.setpos(".", { bufnr, start_row + 1, start_col + 1, 0 })
	vim.cmd("normal! v")
	vim.fn.setpos(".", { bufnr, end_row + 1, end_col + 1, 0 })
end
--]]
--
