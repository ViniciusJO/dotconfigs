return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim',             config = true }, -- Adapters package manager
    { 'williamboman/mason-lspconfig.nvim' },      -- LSP Mason integration
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'antosha417/nvim-lsp-file-operations', config = true },
    { 'j-hui/fidget.nvim',                   tag = 'legacy' }, -- Shows tasks progress
    { 'folke/neoconf.nvim' },
    { 'folke/neodev.nvim' },                          -- Neovim completions and lsp
    { 'VonHeikemen/lsp-zero.nvim',           branch = 'v3.x' }, -- Startpoint LSP
    { 'stevanmilic/nvim-lspimport' },
  },
  config = function()
    require('fidget').setup()
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
      local wk = require('which-key');

      vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { desc = 'Type Definition' })

      wk.add({ { '<leader>l', desc = 'LSP' } });
      vim.keymap.set('n', '<leader>lf', buf.format, { desc = 'Format' })
      vim.keymap.set('n', '<leader>lr', buf.rename, { desc = 'Rename' })
      vim.keymap.set('n', '<leader>la', buf.code_action, { desc = 'Code Actions' })

      vim.keymap.set('n', '<leader>lR', ':LspRestart<cr>', { desc = 'Restart LSP' })

      wk.add({ { '<leader>w', desc = 'Workspace' } });
      vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Workspace Add Folder' })
      vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Workspace Remove Folder' })
      vim.keymap.set('n', '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
        { desc = 'Workspace Symbols' })
      vim.keymap.set('n', '<leader>ww', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        { desc = 'Workspace List Folders' })

      wk.add({ { '<leader>g', desc = 'Goto' } });
      vim.keymap.set('n', '<leader>ds', require('telescope.builtin').lsp_document_symbols, { desc = 'Document Symbols' })

      vim.keymap.set('n', '<leader>gd', buf.definition, { desc = 'Goto Definition' })
      vim.keymap.set('n', '<leader>gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
      vim.keymap.set('n', '<leader>gI', buf.implementation, { desc = 'Goto Implementation' })
      vim.keymap.set('n', '<leader>gR', require('telescope.builtin').lsp_references, { desc = 'Goto References' })
      vim.keymap.set('n', 'gd', buf.definition, { desc = 'Goto Definition' })
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Goto Declaration' })
      vim.keymap.set('n', 'gI', buf.implementation, { desc = 'Goto Implementation' })
      vim.keymap.set('n', 'gR', require('telescope.builtin').lsp_references, { desc = 'Goto References' })

      -- vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover Documentation' })
      vim.keymap.set('i', '<C-\\>', vim.lsp.buf.signature_help, { desc = 'Signature Documentation' })

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
      },
      svelte = {},
      zls = {},
      eslint = {},
      yamlls = {},
      dockerls = {},
      docker_compose_language_service = {},
      bashls = {},
      ast_grep = {},
      pyright = {},
      marksman = {},
      rust_analyzer = {},
      clangd = {
        cmd = {"clangd", "--compile-commands-dir=."},
        -- root_dir = require('lspconfig.util').root_pattern('compile_commands.json', '.git'),
      },
      html = {},
      remark_ls = {},
      taplo = {},
      cssmodules_ls = {},
      ts_ls = {},
      css_variables = {},
      asm_lsp = {},
      arduino_language_server = {},
      markdown_oxide = {},
      cssls = {},
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
