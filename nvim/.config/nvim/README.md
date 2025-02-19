# Vimninho

Vininho's nvim config

## Options

  - Line numbers
    - `vim.o.number = true`
    - `vim.o.relativenumber = true`

  - Wrap
    - `vim.o.wrap = false`

  - Tabstop
    - `vim.o.tabstop = 2`
    - `vim.o.shiftwidth = 2`
    - `vim.o.smarttab = true`
    - `vim.o.expandtab = true`

  - Splits
    - `vim.opt.splitbelow = true`
    - `vim.opt.splitright = true`

  - Colors
    - `vim.o.termguicolors = true`

  - Enable break indent
    - `vim.o.breakindent = true`

  - Save undo history
    - `vim.o.undofile = true`

  - Case-insensitive search by default
    - `vim.o.ignorecase = true`
    - `vim.o.smartcase = true`

  - Highlight on search
    - `vim.o.hlsearch = true`

  - Signcolumn on by default
    - `vim.wo.signcolumn = 'yes'`

  - Completeopt
    - `vim.o.completeopt = 'menuone,noselect,preview'`

  - Mouse enabled
    - `vim.o.mouse = 'a'`


## Plugins

  - [`alpha-nvim`]()
  - [`baleia.nvim`]()
  - [`bufferline.nvim`]()
  - [`catppuccin`]()
  - [`cmp-buffer`]()
  - [`cmp-calc`]()
  - [`cmp-cmdline`]()
  - [`cmp-nvim-lsp`]()
  - [`cmp-path`]()
  - [`cmp_luasnip`]()
  - [`cobalt`]()
  - [`codesmell_dark`]()
  - [`compile-mode.nvim`]()
  - [`data-viewer.nvim`]()
  - [`diffview.nvim`]()
  - [`dired.nvim`]()
  - [`enfocado`]()
  - [`fidget.nvim`]()
  - [`fzf-lua`]()
  - [`hex.nvim`]()
  - [`hover.nvim`]()
  - [`hydra.nvim`]()
  - [`image.nvim`]()
  - [`indent-blankline.nvim`]()
  - [`kanegawa`]()
  - [`lazy.nvim`]()
  - [`log-highlight.nvim`]()
  - [`lsp-zero.nvim`]()
  - [`LuaSnip`]()
  - [`mason-lspconfig.nvim`]()
  - [`mason-nvim-dap.nvim`]()
  - [`mason-tool-installer.nvim`]()
  - [`mason.nvim`]()
  - [`mini.icons`]()
  - [`mini.nvim`]()
  - [`mini.pick`]()
  - [`multicursors.nvim`]()
  - [`neo-tree.nvim`]()
  - [`neoconf.nvim`]()
  - [`neodev.nvim`]()
  - [`neogit`]()
  - [`netman.nvim`]()
  - [`nui.nvim`]()
  - [`nvim-cmp`]()
  - [`nvim-colorizer.lua`]()
  - [`nvim-dap`]()
  - [`nvim-dap-ui`]()
  - [`nvim-lsp-file-operations`]()
  - [`nvim-lspconfig`]()
  - [`nvim-lspimport`]()
  - [`nvim-navic`]()
  - [`nvim-nio`]()
  - [`nvim-treesitter`]()
  - [`nvim-treesitter-textobjects`]()
  - [`nvim-ts-context-commentstring`]()
  - [`nvim-ufo`]()
  - [`nvim-web-devicons`]()
  - [`oil.nvim`]()
  - [`oxocarbon`]()
  - [`plenary.nvim`]()
  - [`promise-async`]()
  - [`render-markdown.nvim`]()
  - [`sqlite.lua`]()
  - [`telescope-file-browser.nvim`]()
  - [`telescope-fzf-native.nvim`]()
  - [`telescope-undo.nvim`]()
  - [`telescope.nvim`]()
  - [`todo-comments.nvim`]()
  - [`transparent.nvim`]()
  - [`twoslash-queries.nvim`]()
  - [`undotree`]()
  - [`vim-fugitive`]()
  - [`which-key.nvim`]()
  - [`trouble.nvim`]()
  - [`vi-mongo.nvim`]()

## Default

### LSPs / DAPs

  - [`ansible-language-server`]()
  - [`ansible-lint`]()
  - [`arduino-language-server`]()
  - [`asmfmt`]()
  - [`bash-language-server`]()
  - [`beautysh`]()
  - [`buf-language-server`]()
  - [`checkmake`]()
  - [`clang-format`]()
  - [`clangd`]()
  - [`cmake-language-server`]()
  - [`cmakelang`]()
  - [`cmakelint`]()
  - [`codelldb`]()
  - [`cpplint`]()
  - [`cpptools`]()
  - [`css-lsp`]()
  - [`css-variables-language-server`]()
  - [`cssmodules-language-server`]()
  - [`dart-debug-adapter`]()
  - [`dcm`]()
  - [`docker-compose-language-service`]()
  - [`dockerfile-language-server`]()
  - [`eslint-lsp`]()
  - [`eslint_d`]()
  - [`firefox-debug-adapter`]()
  - [`gitleaks`]()
  - [`gitlint`]()
  - [`gitui`]()
  - [`glow`]()
  - [`glsl_analyzer`]()
  - [`glslls`]()
  - [`html-lsp`]()
  - [`htmlbeautifier`]()
  - [`htmlhint`]()
  - [`js-debug-adapter`]()
  - [`json-lsp`]()
  - [`jsonnetfmt`]()
  - [`latexindent`]()
  - [`ltex-ls`]()
  - [`lua-language-server`]()
  - [`luacheck`]()
  - [`luaformatter`]()
  - [`markdown-oxide`]()
  - [`marksman`]()
  - [`markuplint`]()
  - [`prettier`]()
  - [`prettierd`]()
  - [`pyright`]()
  - [`remark-language-server`]()
  - [`rust-analyzer`]()
  - [`shellcheck`]()
  - [`shfmt`]()
  - [`sqlfmt`]()
  - [`sqls`]()
  - [`svelte-language-server`]()
  - [`systemdlint`]()
  - [`taplo`]()
  - [`tree-sitter-cli`]()
  - [`ts-standard`]()
  - [`typescript-language-server`]()
  - [`xmlformatter`]()
  - [`yaml-language-server`]()
  - [`yamlfix`]()
  - [`yamlfmt`]()
  - [`yamllint`]()
  - [`zls`]()

### TreeSitter

  - `c`
  - `lua`
  - `markdown`
  - `markdown_inline`
  - `query`
  - `vim`
  - `vimdoc`

## Custom 

### Keymaps

<!--:lua vim.print(vim.api.nvim_get_keymap("n"))-->
<!--:lua for _, map in ipairs(vim.api.nvim_get_keymap("n")) do print("  - `", string.gsub(map.lhs, " ", "<leader>"), "`: ", map.desc) end-->

  - ` <leader>m `:  Create a selection for selected text or word under the cursor
  - ` <leader>gR `:  Goto References
  - ` <leader>gI `:  Goto Implementation
  - ` <leader>gD `:  Goto Declaration
  - ` <leader>gd `:  Goto Definition
  - ` <leader>ds `:  Document Symbols
  - ` <leader>ww `:  Workspace List Folders
  - ` <leader>ws `:  Workspace Symbols
  - ` <leader>wr `:  Workspace Remove Folder
  - ` <leader>wa `:  Workspace Add Folder
  - ` <leader>lR `:  Restart LSP
  - ` <leader>la `:  Code Actions
  - ` <leader>lr `:  Rename
  - ` <leader>lf `:  Format
  - ` <leader>D `:  Type Definition
  - ` <leader>lp `:  Preprocess C File
  - ` <leader>a `:  Code of char under cursor
  - ` <leader>X `:  Toggle split terminal [vertcal]
  - ` <leader>x `:  Toggle split terminal
  - ` <leader>h `:  Toggle search highlight
  - ` <leader>dd `:  Open floating diagnostic message
  - ` <leader>r `:  Source configs
  - ` <leader>lc `:  Compile mode
  - ` <leader>dB `:  Debug: Set Conditional Breakpoint
  - ` <leader>db `:  Debug: Toggle Breakpoint
  - ` <leader>. `:  Toogle transparency
  - ` <leader>fu `:  Find Undo History
  - ` <leader>u `:  Undotree Toggle
  - ` <leader>c `:  Close Current Buffer
  - ` <leader>f/ `:  Find /: Fuzzily search in current buffer
  - ` <leader>ft `:  File tree
  - ` <leader>fr `:  Find Resume
  - ` <leader>fd `:  Find Diagnostics
  - ` <leader>fl `:  Find Live Grep
  - ` <leader>fw `:  Find Word
  - ` <leader>fh `:  Find Help
  - ` <leader>ff `:  Find File
  - ` <leader>fg `:  Find Git Files
  - ` <leader>fb `:  Find existing Buffers
  - ` <leader>fo `:  Find recently Opened files
  - ` <leader>l/ `:  Two Slash Inspect
  - ` <leader>li `:  Auto Import on file
  - ` <leader>e `:  Toggle Neotree
  - ` <leader>vm `:  ViMongo
  - ` <leader>tt `:  Diagnostics (Trouble)
  - ` <leader>tQ `:  Quickfix List (Trouble)
  - ` <leader>tL `:  Location List (Trouble)
  - ` <leader>tl `:  LSP Definitions / references / ... (Trouble)
  - ` <leader>ts `:  Symbols (Trouble)
  - ` <leader>tT `:  Buffer Diagnostics (Trouble)
  - ` % `:  nil
  - ` & `:  :help &-default
  - ` K `:  Hover Documentation
  - ` Q `:  Plays macro at q
  - ` Y `:  Yank to systems clipboard
  - ` [% `:  nil
  - ` [y `:  Yank backward
  - ` [Y `:  Yank first
  - ` [w `:  Window backward
  - ` [W `:  Window first
  - ` [u `:  Undo backward
  - ` [U `:  Undo first
  - ` [t `:  Treesitter backward
  - ` [T `:  Treesitter first
  - ` [q `:  Quickfix backward
  - ` [Q `:  Quickfix first
  - ` [l `:  Location backward
  - ` [L `:  Location first
  - ` [o `:  Oldfile backward
  - ` [O `:  Oldfile first
  - ` [j `:  Jump backward
  - ` [J `:  Jump first
  - ` [i `:  Go to indent scope top
  - ` [I `:  Indent first
  - ` [f `:  File backward
  - ` [F `:  File first
  - ` [D `:  Diagnostic first
  - ` [x `:  Conflict backward
  - ` [X `:  Conflict first
  - ` [c `:  Comment backward
  - ` [C `:  Comment first
  - ` [b `:  Buffer backward
  - ` [B `:  Buffer first
  - ` [d `:  Go to previous diagnostic message
  - ` ]% `:  nil
  - ` ]y `:  Yank forward
  - ` ]Y `:  Yank last
  - ` ]w `:  Window forward
  - ` ]W `:  Window last
  - ` ]u `:  Undo forward
  - ` ]U `:  Undo last
  - ` ]t `:  Treesitter forward
  - ` ]T `:  Treesitter last
  - ` ]q `:  Quickfix forward
  - ` ]Q `:  Quickfix last
  - ` ]l `:  Location forward
  - ` ]L `:  Location last
  - ` ]o `:  Oldfile forward
  - ` ]O `:  Oldfile last
  - ` ]j `:  Jump forward
  - ` ]J `:  Jump last
  - ` ]i `:  Go to indent scope bottom
  - ` ]I `:  Indent last
  - ` ]f `:  File forward
  - ` ]F `:  File last
  - ` ]D `:  Diagnostic last
  - ` ]x `:  Conflict forward
  - ` ]X `:  Conflict last
  - ` ]c `:  Comment forward
  - ` ]C `:  Comment last
  - ` ]b `:  Buffer forward
  - ` ]B `:  Buffer last
  - ` ]d `:  Go to next diagnostic message
  - ` gR `:  Goto References
  - ` gI `:  Goto Implementation
  - ` gD `:  Goto Declaration
  - ` gd `:  Goto Definition
  - ` gh `:  Goto help
  - ` g% `:  nil
  - ` gK `:  Hover Documentation (select)
  - ` gss `:  Sort line
  - ` gs `:  Sort operator
  - ` grr `:  Replace line
  - ` gr `:  Replace operator
  - ` gmm `:  Multiply line
  - ` gm `:  Multiply operator
  - ` gxx `:  Exchange line
  - ` g== `:  Evaluate line
  - ` g= `:  Evaluate operator
  - ` gcc `:  Toggle comment line
  - ` gc `:  Toggle comment
  - ` gx `:  Exchange operator
  - ` j `:  nil
  - ` k `:  nil
  - ` shn `:  Highlight next surrounding
  - ` sFn `:  Find next left surrounding
  - ` sfn `:  Find next right surrounding
  - ` srn `:  Replace next surrounding
  - ` sdn `:  Delete next surrounding
  - ` shl `:  Highlight previous surrounding
  - ` sFl `:  Find previous left surrounding
  - ` sfl `:  Find previous right surrounding
  - ` srl `:  Replace previous surrounding
  - ` sdl `:  Delete previous surrounding
  - ` sn `:  Update `MiniSurround.config.n_lines`
  - ` sh `:  Highlight surrounding
  - ` sF `:  Find left surrounding
  - ` sf `:  Find right surrounding
  - ` sr `:  Replace surrounding
  - ` sd `:  Delete surrounding
  - ` sa `:  Add surrounding
  - ` u `:  nil
  - ` y<C-G> `:  nil
  - ` zM `:  nil
  - ` zR `:  nil
  - ` <M-t> `:  Toggle floating term
  - ` <M-x> `:  Execute command in place and replace
  - ` <C-X> `:  Execute command in place
  - ` <C-Right> `:  Horizontally resize windows (-)
  - ` <C-Left> `:  Horizontally resize windows (+)
  - ` <C-Down> `:  Vertically resize windows (-)
  - ` <C-Up> `:  Vertically resize windows (+)
  - ` <M-r> `:  Toggle relative collumn number
  - ` <M-z> `:  Toggle wrap
  - ` <M-A> `:  Toggle arrow keys
  - ` <C-Q> `:  Quit window
  - ` <C-S> `:  Save buffer to file
  - ` <Plug>(MatchitNormalMultiForward) `:  nil
  - ` <Plug>(MatchitNormalMultiBackward) `:  nil
  - ` <Plug>(MatchitNormalBackward) `:  nil
  - ` <Plug>(MatchitNormalForward) `:  nil
  - ` <MouseMove> `:  Hover Documentation (mouse)
  - ` <C-N> `:  Hover Documentation (next source)
  - ` <C-P> `:  Hover Documentation (previous source)
  - ` <M-E> `:  Dired
  - ` <M-e> `:  Dired
  - ` <Plug>(dired_quit) `:  nil
  - ` <Plug>(dired_toggle_hide_details) `:  nil
  - ` <Plug>(dired_toggle_icons) `:  nil
  - ` <Plug>(dired_toggle_colors) `:  nil
  - ` <Plug>(dired_toggle_sort_order) `:  nil
  - ` <Plug>(dired_toggle_hidden) `:  nil
  - ` <Plug>(dired_create) `:  nil
  - ` <Plug>(dired_mark_range) `:  nil
  - ` <Plug>(dired_mark) `:  nil
  - ` <Plug>(dired_paste) `:  nil
  - ` <Plug>(dired_move_range) `:  nil
  - ` <Plug>(dired_move_marked) `:  nil
  - ` <Plug>(dired_move) `:  nil
  - ` <Plug>(dired_copy_range) `:  nil
  - ` <Plug>(dired_copy_marked) `:  nil
  - ` <Plug>(dired_copy) `:  nil
  - ` <Plug>(dired_delete_marked) `:  nil
  - ` <Plug>(dired_delete_range) `:  nil
  - ` <Plug>(dired_delete) `:  nil
  - ` <Plug>(dired_rename) `:  nil
  - ` <Plug>(dired_enter) `:  nil
  - ` <Plug>(dired_up) `:  nil
  - ` <Plug>(dired_back) `:  nil
  - ` <Plug>fugitive: `:  nil
  - ` <Plug>fugitive:y<C-G> `:  nil
  - ` <F7> `:  Debug: See last session result.
  - ` <F3> `:  Debug: Step Out
  - ` <F2> `:  Debug: Step Over
  - ` <F1> `:  Debug: Step Into
  - ` <F5> `:  Debug: Start/Continue
  - ` <M-k> `:  Move line up
  - ` <M-j> `:  Move line down
  - ` <M-l> `:  Move line right
  - ` <M-h> `:  Move line left
  - ` <C-R> `:  nil
  - ` <Plug>luasnip-expand-repeat `:  LuaSnip: Repeat last node expansion
  - ` <Plug>luasnip-delete-check `:  LuaSnip: Removes current snippet from jumplist
  - ` <Plug>PlenaryTestFile `:  nil
  - ` <C-W><C-D> `:  Show diagnostics under the cursor
  - ` <C-W>d `:  Show diagnostics under the cursor
  - ` <C-L> `:  :help CTRL-L-default

<!--{ "n" = "normal", "i" = "insert", "v" = "visual", "x" = "visual+select", "s" = "select", "o" = "operator-pending", "t" = "terminal", "c" = "command-line" }-->

:lua m = { "n" = "normal", "i" = "insert", "v" = "visual", "x" = "visual+select", "s" = "select", "o" = "operator-pending", "t" = "terminal", "c" = "command-line" }; for modechar, mode in ipairs(m) do vim.print("  - ", mode); for _, map in ipairs(vim.api.nvim_get_keymap("i")) do print("    - `", string.gsub(map.lhs, " ", "<leader>"), "`: ", map.desc) end

:lua local function title_case(str) return str:gsub("(%a)(%w*)", function(first, rest) return first:upper() .. rest:lower() end) end  local m = { n = "normal", i = "insert", v = "visual", x = "visual+select", s = "select", o = "operator-pending", t = "terminal", c = "command-line" };  for modechar, mode in pairs(m) do print("  - *" .. title_case(mode) .. "*"); for _, map in ipairs(vim.api.nvim_get_keymap(modechar)) do print("    - `", string.gsub(map.lhs, " ", "<leader>"), "`: ", map.desc) end end  


### Aucmds

## Colorschemes

  - [`oxocarbon`]()
  - [`enfocado`]()



  <!--- `alpha-nvim`-->
  <!--- `baleia.nvim`-->
  <!--- `bufferline.nvim`-->
  <!--- `catppuccin`-->
  <!--- `cmp-buffer`-->
  <!--- `cmp-calc`-->
  <!--- `cmp-cmdline`-->
  <!--- `cmp-nvim-lsp`-->
  <!--- `cmp-path`-->
  <!--- `cmp_luasnip`-->
  <!--- `cobalt`-->
  <!--- `codesmell_dark`-->
  <!--- `compile-mode.nvim`-->
  <!--- `data-viewer.nvim`-->
  <!--- `diffview.nvim`-->
  <!--- `dired.nvim`-->
  <!--- `enfocado`-->
  <!--- `fidget.nvim`-->
  <!--- `fzf-lua`-->
  <!--- `hex.nvim`-->
  <!--- `hover.nvim`-->
  <!--- `hydra.nvim`-->
  <!--- `image.nvim`-->
  <!--- `indent-blankline.nvim`-->
  <!--- `kanegawa`-->
  <!--- `lazy.nvim`-->
  <!--- `log-highlight.nvim`-->
  <!--- `lsp-zero.nvim`-->
  <!--- `LuaSnip`-->
  <!--- `mason-lspconfig.nvim`-->
  <!--- `mason-nvim-dap.nvim`-->
  <!--- `mason-tool-installer.nvim`-->
  <!--- `mason.nvim`-->
  <!--- `mini.icons`-->
  <!--- `mini.nvim`-->
  <!--- `mini.pick`-->
  <!--- `multicursors.nvim`-->
  <!--- `neo-tree.nvim`-->
  <!--- `neoconf.nvim`-->
  <!--- `neodev.nvim`-->
  <!--- `neogit`-->
  <!--- `netman.nvim`-->
  <!--- `nui.nvim`-->
  <!--- `nvim-cmp`-->
  <!--- `nvim-colorizer.lua`-->
  <!--- `nvim-dap`-->
  <!--- `nvim-dap-ui`-->
  <!--- `nvim-lsp-file-operations`-->
  <!--- `nvim-lspconfig`-->
  <!--- `nvim-lspimport`-->
  <!--- `nvim-navic`-->
  <!--- `nvim-nio`-->
  <!--- `nvim-treesitter`-->
  <!--- `nvim-treesitter-textobjects`-->
  <!--- `nvim-ts-context-commentstring`-->
  <!--- `nvim-ufo`-->
  <!--- `nvim-web-devicons`-->
  <!--- `oil.nvim`-->
  <!--- `oxocarbon`-->
  <!--- `plenary.nvim`-->
  <!--- `promise-async`-->
  <!--- `render-markdown.nvim`-->
  <!--- `sqlite.lua`-->
  <!--- `telescope-file-browser.nvim`-->
  <!--- `telescope-fzf-native.nvim`-->
  <!--- `telescope-undo.nvim`-->
  <!--- `telescope.nvim`-->
  <!--- `todo-comments.nvim`-->
  <!--- `transparent.nvim`-->
  <!--- `twoslash-queries.nvim`-->
  <!--- `undotree`-->
  <!--- `vim-fugitive`-->
  <!--- `which-key.nvim`-->
  <!--- `trouble.nvim`-->
  <!--- `vi-mongo.nvim`-->
