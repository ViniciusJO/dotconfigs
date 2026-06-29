local function run_cmd_capture(cmd)
  vim.v.errmsg = ""
  vim.cmd("redir => g:__cmd_output")
  vim.cmd("silent " .. cmd)
  vim.cmd("redir END")

  local out = vim.g.__cmd_output or ""
  vim.g.__cmd_output = nil

  return out, vim.v.errmsg
end

-- TODO: fix closing fyler sidebar with :q crash

return {
  "A7Lavinraj/fyler.nvim",
  -- dependencies = { "nvim-mini/mini.icons" },
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- branch = "stable",
  lazy = false,
  opts = {
    integrations = { icon = "nvim_web_devicons", },
    views = {
      finder = {
        close_on_select = true,
        confirm_simple = false,
        default_explorer = true,
        delete_to_trash = true,
        columns = {
          git = {
            enabled = true,
            symbols = {
              Untracked = "?",
              Added = "+",
              Modified = "*",
              Deleted = "x",
              Renamed = ">",
              Copied = "~",
              Conflict = "!",
              Ignored = "#",
            },
          },
        },
        icon = {
          directory_collapsed = nil,
          directory_empty = nil,
          directory_expanded = nil,
        },
        indentscope = {
          enabled = true,
          group = "FylerIndentMarker",
          marker = "│",
        },
        mappings = {
          ["q"] = "CloseView",
          ["<CR>"] = "Select",
          ["<C-t>"] = "SelectTab",
          ["|"] = "SelectVSplit",
          ["-"] = "SelectSplit",
          ["^"] = "GotoParent",
          ["="] = "GotoCwd",
          ["."] = "GotoNode",
          ["#"] = "CollapseAll",
          ["<BS>"] = "CollapseNode",
        },
        mappings_opts = {
          nowait = false,
          noremap = true,
          silent = true,
        },
        follow_current_file = true,
        watcher = { enabled = false, },
        win = {
          border = vim.o.winborder == "" and "single" or vim.o.winborder,
          buf_opts = {
            filetype = "fyler",
            syntax = "fyler",
            buflisted = false,
            buftype = "acwrite",
            expandtab = true,
            shiftwidth = 2,
          },
          kind = "replace",
          kinds = {
            float = {
              height = "70%",
              width = "70%",
              top = "10%",
              left = "15%",
            },
            replace = {},
            split_above = { height = "70%", },
            split_above_all = {
              height = "70%",
              win_opts = {
                winfixheight = true,
              },
            },
            split_below = {
              height = "70%",
            },
            split_below_all = {
              height = "70%",
              win_opts = {
                winfixheight = true,
              },
            },
            split_left = {
              width = "30%",
            },
            split_left_most = {
              width = "30%",
              win_opts = { winfixwidth = true, },
            },
            split_right = {
              width = "30%",
            },
            split_right_most = {
              width = "30%",
              win_opts = {
                winfixwidth = true,
              },
            },
          },
          win_opts = {
            concealcursor = "nvic",
            conceallevel = 3,
            cursorline = false,
            number = false,
            relativenumber = false,
            winhighlight = "Normal:FylerNormal,NormalNC:FylerNormalNC",
            wrap = false,
            signcolumn = "yes",
          },
        }
      }
    }
  },
  keys = { { "<leader>e", function()
    local fyler = require("fyler");

    if vim.bo.filetype == "alpha" then
      fyler.toggle({ kind = "replace" });
    elseif vim.bo.filetype ~= "fyler" then
      fyler.toggle({ kind = "split_left_most" });
    elseif #vim.api.nvim_tabpage_list_wins(0) > 1 then
      fyler.toggle({ kind = "split_left_most" });
    else
      run_cmd_capture("Alpha");
    end
  end, desc = "Open Fyler explorer" }, },
  init = function()
    local fyler = require("fyler");
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        local args = vim.fn.argv()
        local is_dir = #args == 1 and vim.fn.isdirectory(args[1]) == 1
        if is_dir then
          vim.cmd("e " .. args[1]) -- Open the directory
          fyler.open({ kind = "replace" }) -- Open it with oil.nvim
          vim.bo.buflisted = false;
        end
      end,
    })
  end
}
