return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- { 'williamboman/mason.nvim',             config = true }, -- Adapters package manager
    -- { 'williamboman/mason-lspconfig.nvim' },      -- LSP Mason integration
    { "mason-org/mason.nvim",                     version = "^1.0.0" },
    { "mason-org/mason-lspconfig.nvim",           version = "^1.0.0" },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'antosha417/nvim-lsp-file-operations',      config = true },
    { 'j-hui/fidget.nvim',                        tag = 'legacy' },  -- Shows tasks progress
    { 'folke/neoconf.nvim' },
    { 'folke/neodev.nvim' },                                         -- Neovim completions and lsp
    { 'VonHeikemen/lsp-zero.nvim',                branch = 'v3.x' }, -- Startpoint LSP
    { 'stevanmilic/nvim-lspimport' },
    { 'ziglang/zig.vim' },
  },
  config = function()
    require('fidget').setup()
    require('neoconf').setup()
    require('neodev').setup()
    require('mason').setup()

    local lsp_zero = require('lsp-zero')
    lsp_zero.on_attach(function(_, bufnr)
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
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
    local servers = {
      clangd = {
        -- capabilities = capabilities;
        -- cmd = { "/home/vinicius/.espressif/tools/esp-clang/esp-18.1.2_20240912/esp-clang/bin/clangd", "--background-index", "--query-driver=**", },
        -- root_dir = function()
        --   -- leave empty to stop nvim from cd'ing into ~/ due to global .clangd file
        -- end
        cmd = { "clangd", "--compile-commands-dir=." },
        -- root_dir = require('lspconfig.util').root_pattern('compile_commands.json', '.git'),
      },
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false }
        }
      },
      ansiblels = {},
      -- ["ansible-lint"] = {},
      arduino_language_server = {},
      -- asm_lsp = {},
      asmfmt = {},
      bashls = {},
      beautysh = {},
      ["buf-language-server"] = {},
      checkmake = {},
      ["clang-format"] = {},
      cmake = {},
      cmakelang = {},
      cmakelint = {},
      codelldb = {},
      cpplint = {},
      cpptools = {},
      cssls = {},
      css_variables = {},
      cssmodules_ls = {},
      ["dart-debug-adapter"] = {},
      dcm = {},
      docker_compose_language_service = {},
      dockerls = {},
      eslint = {},
      eslint_d = {},
      ["firefox-debug-adapter"] = {},
      gitleaks = {},
      gitlint = {},
      gitui = {},
      glow = {},
      glsl_analyzer = {},
      glslls = {},
      html = {},
      htmlbeautifier = {},
      htmlhint = {},
      ["js-debug-adapter"] = {},
      jsonls = {},
      jsonnetfmt = {},
      latexindent = {},
      ltex = {},
      luacheck = {},
      luaformatter = {},
      markdown_oxide = {},
      marksman = {},
      markuplint = {},
      -- ["node-debug2-adapter"] = {},
      prettier = {},
      prettierd = {},
      pyright = {},
      remark_ls = {},
      rust_analyzer = {},
      shellcheck = {},
      -- shellharden = {},
      shfmt = {},
      sqlfmt = {},
      sqls = {},
      svelte = {},
      systemdlint = {},
      taplo = {},
      ["tree-sitter-cli"] = {},
      ["ts-standard"] = {},
      ts_ls = {},
      xmlformatter = {},
      yamlls = {},
      yamlfix = {},
      yamlfmt = {},
      yamllint = {},
      zls = {

      }
    }

    -- TODO: refactor to proper location
    vim.g.zig_fmt_autosave = 0

    local mason_lspconfig = require 'mason-lspconfig'

    mason_lspconfig.setup()
    -- {
    -- automatic_installation = true,
    -- ensure_installed = vim.tbl_keys(servers),
    -- }

    -- require("mason-tool-installer").setup({
    --   auto_update = true,
    --   ensure_installed = vim.tbl_keys(servers),
    --   run_on_start = true,
    -- })



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

    require('lspconfig.ui.windows').default_options.border = 'double'
    vim.keymap.set("n", "<leader>li", require("lspimport").import, { noremap = true, desc = "Auto Import on file" })

    local lspconfig = require('lspconfig')

    function StopClangd()
      for _, client in ipairs(vim.lsp.get_active_clients()) do
        if client.name == "clangd" then
          client.stop()
        end
      end
    end

    -- Função para reconfigurar o clangd dinamicamente
    function ChangeClangd(cmd_path)
      StopClangd()

      -- Reconfigurar clangd com novo cmd
      lspconfig.clangd.setup{
        cmd = { cmd_path },
      }

      -- Reatachar clangd ao buffer atual
      vim.cmd("edit") -- Força reanalisar o buffer atual
    end

    -- Comando para usar clangd normal do sistema
    vim.api.nvim_create_user_command("SystemClangd", function()
      ChangeClangd("clangd")
      print("Switched to system clangd")
    end, {})

    -- Comando para usar clangd do ESP-IDF
    vim.api.nvim_create_user_command("IdfClangd", function()
      ChangeClangd("/home/vinicius/.espressif/tools/esp-clang/esp-18.1.2_20240912/esp-clang/bin/clangd")
      print("Switched to ESP-IDF clangd")
    end, {})







    -- require('lspconfig').setup()

    -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    --   border = "rounded",
    -- })
    --
    -- local ok, fidget = pcall(require, "fidget")
    -- if not ok then
    --   vim.notify("Fidget not found", vim.log.levels.WARN)
    --   return
    -- end
    --
    -- local progress = require("fidget").progress
    --
    -- vim.notify = function(msg, level, opts)
    --   local notif = progress.handle.create({
    --     title = "Notification",
    --     message = msg,
    --     percentage = nil,
    --     lsp_client = { name = "user" },
    --   })
    --
    --   -- Close after a few seconds
    --   vim.defer_fn(function()
    --     notif:finish()
    --   end, 3000)
    -- end
    --
    -- vim.api.nvim_echo = function(chunks, _history, _opts)
    --   for _, chunk in ipairs(chunks) do
    --     local text = chunk[1]
    --     vim.notify(text)
    --   end
    -- end

  end
}
