ansible-lint
asmfmt
beautysh
buf-language-server
checkmake
clang-format
cmake
cmakelang
cmakelint
codelldb
cpplint
cpptools
dart-debug-adapter
dcm
eslint_d
firefox-debug-adapter
gitleaks
gitlint
gitui
glow
htmlbeautifier
htmlhint
java-debug-adapter
java-test
js-debug-adapter
jsonnetfmt
latexindent
luacheck
luaformatter
markuplint
node-debug2-adapter
prettier
prettierd
shellcheck
shellharden
shfmt
sqlfmt
systemdlint
tree-sitter-cli
ts-standard
xmlformatter
yamlfix
yamlfmt
yamllint









:lua vim.print(require("mason-registry").get_installed_packages())

:lua for _, package in ipairs(require("mason-registry").get_installed_packages()) do print(package.spec.name) end

:lua for _, package in ipairs(require("lspconfig").util.available_servers()) do print(package.spec.name) end

:lua vim.print(require("lspconfig").util.available_servers())
{ 
    "pyright",
	"remark_ls",
	"rust_analyzer",
	"sqls",
	"svelte",
	"taplo",
	"ts_ls",
	"ansiblels",
	"arduino_language_server",
	"asm_lsp",
	"zls",
	"bashls",
	"emmet_language_server",
	"cssls",
	"css_variables",
	"cssmodules_ls",
	"docker_compose_language_service",
	"dockerls",
	"eslint",
	"glsl_analyzer",
	"glslls",
	"html",
	"yamlls",
	"lua_ls",
	"jsonls",
	"marksman",
	"ltex",
	"emmet_ls",
	"buf_ls",
	"markdown_oxide",
	"ember",
	"clangd"
}


:lua vim.print(require("mason-registry").get_installed_packages())


:lua for _, package in ipairs(require("mason-registry").get_installed_packages()) do if package.spec.categories[1] == "DAP" then print(package.spec.name) end end

:lua for _, cat in ipairs({ "Compiler", "DAP", "Formatter", "LSP", "Linter", "Runtime"}) do print("# ["..cat.."]"); for _, package in ipairs(require("mason-registry").get_installed_packages()) do if package.spec.categories[1] == cat then print("- `"..package.spec.name.."`") end; end; print("\n") end

# [Compiler]
- `tree-sitter-cli`


# [DAP]
- `js-debug-adapter`
- `firefox-debug-adapter`
- `dart-debug-adapter`
- `codelldb`
- `cpptools`


# [Formatter]
- `xmlformatter`
- `sqlfmt`
- `shfmt`
- `shellharden`
- `prettierd`
- `prettier`
- `luaformatter`
- `latexindent`
- `jsonnetfmt`
- `htmlbeautifier`
- `cmakelang`
- `clang-format`
- `beautysh`
- `asmfmt`
- `yamlfmt`
- `yamlfix`


# [LSP]
- `svelte-language-server`
- `ansible-language-server`
- `sqls`
- `remark-language-server`
- `pyright`
- `marksman`
- `glslls`
- `glsl_analyzer`
- `ltex-ls`
- `json-lsp`
- `emmet-ls`
- `emmet-language-server`
- `buf-language-server`
- `docker-compose-language-service`
- `cssmodules-language-server`
- `css-variables-language-server`
- `css-lsp`
- `eslint-lsp`
- `clangd`
- `bash-language-server`
- `asm-lsp`
- `lua-language-server`
- `rust-analyzer`
- `typescript-language-server`
- `markdown-oxide`
- `dcm`
- `protols`
- `dockerfile-language-server`
- `yaml-language-server`
- `html-lsp`
- `arduino-language-server`
- `taplo`
- `zls`
- `ember-language-server`


# [Linter]
- `ts-standard`
- `systemdlint`
- `shellcheck`
- `markuplint`
- `luacheck`
- `htmlhint`
- `gitlint`
- `gitleaks`
- `eslint_d`
- `jsonlint`
- `cpplint`
- `cmakelint`
- `checkmake`
- `buf`
- `ansible-lint`
- `yamllint`


# [Runtime]


:lua print("# [Plugins]\n"); for _, p in ipairs(require("lazy").plugins()) do vim.print("- `"..p.name.."`") end

# [Plugins]

- `vim-fugitive`
- `twoslash-queries.nvim`
- `log-highlight.nvim`
- `nvim-ufo`
- `promise-async`
- `nvim-colorizer.lua`
- `telescope.nvim`
- `plenary.nvim`
- `which-key.nvim`
- `nvim-cmp`
- `image.nvim`
- `dired.nvim`
- `bufferline.nvim`
- `cmp_luasnip`
- `cmp-nvim-lsp`
- `mason.nvim`
- `cmp-calc`
- `mason-lspconfig.nvim`
- `compile-mode.nvim`
- `hex.nvim`
- `mason-tool-installer.nvim`
- `baleia.nvim`
- `nui.nvim`
- `cmp-buffer`
- `nvim-dap`
- `fidget.nvim`
- `nvim-dap-ui`
- `neoconf.nvim`
- `neogit`
- `transparent.nvim`
- `nvim-nio`
- `diffview.nvim`
- `trouble.nvim`
- `fzf-lua`
- `nvim-web-devicons`
- `mini.pick`
- `vi-mongo.nvim`
- `nvim-navic`
- `todo-comments.nvim`
- `hover.nvim`
- `undotree`
- `cobalt`
- `mini.nvim`
- `oxocarbon`
- `kanegawa`
- `catppuccin`
- `nvim-lspconfig`
- `codesmell_dark`
- `nvim-treesitter`
- `enfocado`
- `telescope-fzf-native.nvim`
- `indent-blankline.nvim`
- `telescope-undo.nvim`
- `lazy.nvim`
- `telescope-file-browser.nvim`
- `oil.nvim`
- `mini.icons`
- `data-viewer.nvim`
- `sqlite.lua`
- `nvim-treesitter-textobjects`
- `multicursors.nvim`
- `hydra.nvim`
- `nvim-ts-context-commentstring`
- `neodev.nvim`
- `nvim-lspimport`
- `cmp-cmdline`
- `lsp-zero.nvim`
- `mason-nvim-dap.nvim`
- `netman.nvim`
- `nvim-lsp-file-operations`
- `neo-tree.nvim`
- `cmp-path`
- `LuaSnip`
