return {
  "nolleh/sqlflick.nvim",
  config = function()
    require("sqlflick").setup({
      databases = {
      --   {
      --     name = "local_mysql",
      --     type = "mysql",
      --     host = "localhost",
      --     port = 3306,
      --     database = "mydb",
      --     username = "user",
      --     password = "pass"
      --   },
        {
          name = "test_sqlite",
          type = "sqlite",
          database = "/home/vinicius/Code/codebase/C/learn/sqlite/test.db"
        },
      },
    })
  end,
  -- recommended load plugin option
  cmd = { "SQLFlickSelectDB", "SQLFlickExecute", "SQLFlickExecuteBuf", "SQLFlickInstall", "SQLFlickRestart" },
  -- If you want to load/enable the plugin only for specific file_type, use this
}
