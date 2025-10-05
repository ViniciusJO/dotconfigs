return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "VeryLazy",   -- Or `LspAttach`
  priority = 1000,      -- needs to be loaded in first
  config = function()
    require('tiny-inline-diagnostic').setup({
      preset = 'nonerdfont',
      options = {
        show_source = { enable = true, if_many = true },
      },
      virt_texts = {
        -- Priority for virtual text display
        priority = 2050,
      },
    })
    -- vim.diagnostic.config({ virtual_text = false })     -- Only if needed in your configuration, if you already have native LSP diagnostics
  end
}
