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
  opts = { integrations = { icon = "nvim_web_devicons", } },
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
