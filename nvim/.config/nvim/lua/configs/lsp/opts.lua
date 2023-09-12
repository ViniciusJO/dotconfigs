local M = {}

M.on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end
  local buf = vim.lsp.buf

  require('which-key').register({
    ['<leader>'] = {
      D = { vim.lsp.buf.type_definition, 'Type Definition' },
      l = {
        name = 'Lsp',
        f = { buf.format, "Format" },
        r = { buf.rename, "Rename" },
        a = { buf.code_action, "Code Actions" },

      },
      w = {
        name = "Workspace",
        a = { vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder' },
        r = { vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder' },
        s = { require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols' },
        w = { function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'Workspace List Folders' },
      },
      ds = { require('telescope.builtin').lsp_document_symbols, 'Document Symbols' },
    },
    g = {
      name = 'Goto',
      d = { buf.definition, 'Goto Definition' },
      D = { vim.lsp.buf.declaration, 'Goto Declaration' },
      I = { buf.implementation, 'Goto Implementation' },
      r = { require('telescope.builtin').lsp_references, 'Goto References' }
    },
    K = { vim.lsp.buf.hover, 'Hover Documentation' },
    ['<C-k>'] = { vim.lsp.buf.signature_help, 'Signature Documentation' },
  });

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

M.capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

M.servers = {
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false }
    }
  }

  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

}

return M
