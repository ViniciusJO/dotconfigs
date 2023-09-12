local opts = require('configs.lsp.opts')
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(opts.servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = opts.capabilities,
      on_attach = opts.on_attach,
      settings = opts.servers[server_name],
      filetypes = (opts.servers[server_name] or {}).filetypes,
    }
  end
}
