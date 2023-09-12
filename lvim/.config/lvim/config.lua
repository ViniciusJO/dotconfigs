-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.log.level = "warn"
lvim.format_on_save.enabled = false
lvim.colorscheme = "enfocado"

lvim.leader = "space"

lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
lvim.keys.normal_mode["<C-q>"] = ":q<cr>"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"tsx",
	"css",
	"rust",
	"java",
	"yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

lvim.plugins = {
	{ "yamatsum/nvim-nonicons" },
	{ "folke/trouble.nvim" },
	{ "stevearc/dressing.nvim" },
	{ "wuelnerdotexe/vim-enfocado" },
	{ "DaikyXendo/nvim-material-icon" },
	{ "mstanciu552/cmp-octave" },
	{ "mstanciu552/cmp-matlab" },
	{ "hrsh7th/nvim-cmp" },
	{ "MunifTanjim/nui.nvim" },
	{
		"dreamsofcode-io/chatgpt.nvim",
		config = function()
			require("chatgpt").setup({
				async_api_key_cmd = "pass show api/tokens/openai",
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
}

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.fillchars = "fold: "
vim.wo.foldnestmax = 3
vim.wo.foldminlines = 1
vim.wo.foldlevel = 1
vim.wo.foldtext =
	[[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]

-- Configure keymaps for chatgpt.nvim commands under '<space>x' prefix
lvim.builtin.which_key.mappings["ç"] = {
	name = "+ChatGPT",
	["<Leader>"] = { "<cmd>ChatGPT<CR>", "ChatGPT" },
	a = { "<cmd>ChatGPTActAs<CR>", "ChatGPTActAs" },
	c = { "<cmd>ChatGPTCompleteCode<CR>", "ChatGPTCompleteCode" },
	e = { "<cmd>ChatGPTEditWithInstructions<CR>", "ChatGPTEditWithInstructions" },
	r = { "<cmd>ChatGPTRun<CR>", "ChatGPTRun" },
}

-- funccc
local function serializeTable(val, name, skipnewlines, depth)
	skipnewlines = skipnewlines or false
	depth = depth or 0

	local tmp = string.rep(" ", depth)

	if name then
		tmp = tmp .. name .. " = "
	end

	if type(val) == "table" then
		tmp = tmp .. "{" .. (not skipnewlines and "\n" or "")

		for k, v in pairs(val) do
			tmp = tmp .. serializeTable(v, k, skipnewlines, depth + 1) .. "," .. (not skipnewlines and "\n" or "")
		end

		tmp = tmp .. string.rep(" ", depth) .. "}"
	elseif type(val) == "number" then
		tmp = tmp .. tostring(val)
	elseif type(val) == "string" then
		tmp = tmp .. string.format("%q", val)
	elseif type(val) == "boolean" then
		tmp = tmp .. (val and "true" or "false")
	else
		tmp = tmp .. '"[inserializeable datatype:' .. type(val) .. ']"'
	end

	return tmp
end

str = serializeTable(require("cmp"), nil, true)

table.insert(lvim.builtin.cmp, { name = "cmp_matlab" })
table.insert(lvim.builtin.cmp, { name = "cmp_matlab" })
