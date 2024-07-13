return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true },     -- Adapters package manager
    'williamboman/mason-lspconfig.nvim',              -- LSP Mason integration
    { 'j-hui/fidget.nvim',       tag = 'legacy' },    -- Shows tasks progress
    'folke/neoconf.nvim',
    'folke/neodev.nvim',                              -- Neovim completions and lsp
    { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' }, -- Startpoint LSP
    { "stevanmilic/nvim-lspimport" },
  },
  config = function(opts)
    require('neoconf').setup()
    require('neodev').setup()

    local lsp_zero = require('lsp-zero')
    lsp_zero.on_attach(function(client, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      lsp_zero.default_keymaps({ buffer = bufnr })
    end)

    local on_attach = function(client, bufnr)
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
        -- K = { vim.lsp.buf.hover, 'Hover Documentation' },
        ['<C-k>'] = { vim.lsp.buf.signature_help, 'Signature Documentation' },
      });

      if client.server_capabilities["documentSymbolProvider"] then
        require("nvim-navic").attach(client, bufnr)
      end
      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })
    end
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
    local servers = {
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

    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup {
      ensure_installed = vim.tbl_keys(servers),
    }

    mason_lspconfig.setup_handlers {
      function(server_name)
        require('lspconfig')[server_name].setup {
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        }
      end
    }

    require('lspconfig.ui.windows').default_options.border = 'single'
    vim.keymap.set("n", "<leader>li", require("lspimport").import, { noremap = true, desc = "Auto Import on file" })
    -- require('lspconfig').setup()
  end
}
