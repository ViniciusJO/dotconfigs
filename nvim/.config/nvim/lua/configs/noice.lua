--require("noice").setup({
--  lsp = {
--    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
--    override = {
--      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--      ["vim.lsp.util.stylize_markdown"] = true,
--      ["cmp.entry.get_documentation"] = true,
--    },
--  },
--  -- you can enable a preset for easier configuration
--  presets = {
--    bottom_search = true, -- use a classic bottom cmdline for search
--    command_palette = true, -- position the cmdline and popupmenu together
--    long_message_to_split = true, -- long messages will be sent to a split
--    inc_rename = false, -- enables an input dialog for inc-rename.nvim
--    lsp_doc_border = true, -- add a border to hover docs and signature help
--  },
--})

require('noice').setup({
	cmdline = {
		enabled = true,
		view = "cmdline",
		opts = {},
		format = {
			cmdline = { pattern = "^:", icon = "", lang = "vim" },
			search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
			search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
			filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
			lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
			help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
			input = {},
		},
	},
	messages = {
		enabled = true,
		view = "mini",
		view_error = "mini",
		view_warn = "mini",
		view_history = "messages",
		view_search = "virtualtext",
	},
	popupmenu = { enabled = true, backend = "nui", kind_icons = {}, },
	redirect = { view = "mini", filter = { event = "msg_show" }, },
	commands = {
		history = {
			view = "split",
			opts = { enter = true, format = "details" },
			filter = {
				any = { { event = "mini" }, { error = true }, { warning = true }, { event = "msg_show", kind = { "" } },
					{ event = "lsp",   kind = "message" }, },
			},
		},
		last = {
			view = "mini",
			opts = { enter = true, format = "details" },
			filter = {
				any = { { event = "mini" }, { error = true }, { warning = true }, { event = "msg_show", kind = { "" } },
					{ event = "lsp",   kind = "message" }, },
			},
			filter_opts = { count = 1 },
		},
		errors = {
			view = "mini",
			opts = { enter = true, format = "details" },
			filter = { error = true },
			filter_opts = { reverse = true },
		},
	},
	notify = { enabled = true, view = "mini", },
	lsp = {
		progress = {
			enabled = true,
			format = "lsp_progress",
			format_done = "lsp_progress_done",
			throttle = 1000 / 30,
			view = "mini",
		},
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = false,
			["vim.lsp.util.stylize_markdown"] = false,
			["cmp.entry.get_documentation"] = false,
		},
		hover = { enabled = true, silent = false, view = nil, opts = {}, },
		signature = {
			enabled = true,
			auto_open = { enabled = true, trigger = true, luasnip = true, throttle = 50, },
			view = nil,
			opts = {},
		},
		message = { enabled = true, view = "mini", opts = {}, },
		documentation = {
			view = "hover",
			opts = {
				lang = "markdown",
				replace = true,
				render = "plain",
				format = { "{message}" },
				win_options = { concealcursor = "n", conceallevel = 3 },
			},
		},
	},
	markdown = {
		hover = { ["|(%S-)|"] = vim.cmd.help, ["%[.-%]%((%S-)%)"] = require("noice.util").open, },
		highlights = {
			["|%S-|"] = "@text.reference",
			["@%S+"] = "@parameter",
			["^%s*(Parameters:)"] = "@text.title",
			["^%s*(Return:)"] = "@text.title",
			["^%s*(See also:)"] = "@text.title",
			["{%S-}"] = "@parameter",
		},
	},
	health = { checker = true, },
	smart_move = { enabled = true, excluded_filetypes = { "cmp_menu", "cmp_docs", "notify" }, },
	presets = {
		bottom_search = false,
		command_palette = false,
		long_message_to_split = false,
		inc_rename = false,
		lsp_doc_border = false,
	},
	throttle = 1000 / 30,
	views = {},
	routes = {},
	status = {},
	format = {},
})

vim.notify("TESTE")
