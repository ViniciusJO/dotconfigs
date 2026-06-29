-- lua/vitest_qf.lua
local M = {}

-- TODO: FIX

-- Parse vitest JSON output and fill quickfix
local function parse_vitest_output(output)
  local ok, data = pcall(vim.json.decode, output)
  if not ok then
    vim.notify("Failed to parse vitest output", vim.log.levels.ERROR)
    return
  end

  local qf_items = {}
  vim.print(data)

  -- Vitest reporter JSON has a "testResults" array with suites and tests
  if data and data.testResults then
    for _, suite in ipairs(data.testResults) do
      if suite.assertionResults then
        for _, test in ipairs(suite.assertionResults) do
          if test.status == "failed" then
            -- Try to find file and line
            local filename = suite.name or suite.file or ""
            local message = test.failureMessages and table.concat(test.failureMessages, "\n") or "Test failed"

            table.insert(qf_items, {
              filename = filename,
              lnum = test.location.line,
              col = test.location.column,
              text = test.title .. ": " .. message,
            })
          end
        end
      end
    end
  end

  vim.fn.setqflist({}, " ", {
    title = "Vitest Failures",
    items = qf_items,
  })

  if #qf_items > 0 then
    vim.cmd("copen")
  else
    vim.notify("All Vitest tests passed ✅", vim.log.levels.INFO)
    vim.cmd("cclose")
  end
end


-- Run vitest and capture output
function M.run_vitest()
  vim.fn.jobstart({ "npx", "vitest", "run", "--reporter=json" }, {
    stdout_buffered = true,
    on_stdout = function(_, data, _)
      if not data then return end
      table.remove(data, 1)
      table.remove(data, 1)
      local output = table.concat(data, "")
      if #output > 0 then
        parse_vitest_output(output)
      end
    end,
    on_stderr = function(_, data, _)
      if data and #data > 0 then
        vim.notify(table.concat(data, "\n"), vim.log.levels.WARN)
      end
    end,
    on_exit = function(_, code, _)
      if code ~= 0 then
        vim.notify("Vitest exited with code " .. code, vim.log.levels.ERROR)
      end
    end,
  })
end

function M.init()
  vim.api.nvim_create_user_command("Vitest", function()
    require('vitest').run_vitest()
  end, {})

  vim.keymap.set("n", "<leader>vv", function()
    require("vitest").run_vitest()
  end, { desc = "Run Vitest and populate quickfix" })
end

return M

