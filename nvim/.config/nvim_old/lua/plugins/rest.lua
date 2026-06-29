return {
  "rest-nvim/rest.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "http")

      require("telescope").load_extension("rest")
      -- require("telescope").extensions.rest.select_env()
    end,
  }
}
