return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "RchrdAriza/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- local time = os.date("%H:%M")
		-- local date = os.date("%a %d %b")
		-- local v = vim.version()
		-- local version = " v" .. v.major .. "." .. v.minor .. "." .. v.patch

		dashboard.section.header.val = {
			"██╗   ██╗██╗███╗   ███╗███╗   ██╗██╗███╗   ██╗██╗  ██╗ ██████╗ ",
			"██║   ██║██║████╗ ████║████╗  ██║██║████╗  ██║██║  ██║██╔═══██╗",
			"██║   ██║██║██╔████╔██║██╔██╗ ██║██║██╔██╗ ██║███████║██║   ██║",
			"╚██╗ ██╔╝██║██║╚██╔╝██║██║╚██╗██║██║██║╚██╗██║██╔══██║██║   ██║",
			" ╚████╔╝ ██║██║ ╚═╝ ██║██║ ╚████║██║██║ ╚████║██║  ██║╚██████╔╝",
			"  ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝ ",
    }

		-- Set header
    for _ = 1, (vim.api.nvim_win_get_height(0)-2)/2-3, 1 do
      table.insert(dashboard.section.header.val, 0, "")
    end

		dashboard.section.buttons.val = {
			-- dashboard.button("n", "   New file", ":ene <BAR> startinsert <CR>"),
			-- dashboard.button("f", "󰮗   Find file", ":cd $HOME | Telescope find_files<CR>"),
			-- dashboard.button("e", "   File Explorer", ":cd $HOME | Neotree<CR>"),
			-- dashboard.button("r", "   Recent", ":Telescope oldfiles<CR>"),
			-- dashboard.button("c", "   Configuration", ":e ~/.config/nvim/lua/plugins/alpha.lua<CR>"),
			-- dashboard.button("R", "󱘞   Ripgrep", ":Telescope live_grep<CR>"),
			-- dashboard.button("q", "󰗼   Quit", ":qa<CR>"),
		}
		--
		-- function centerText(text, width)
		-- 	local totalPadding = width - #text
		-- 	local leftPadding = math.floor(totalPadding / 2)
		-- 	local rightPadding = totalPadding - leftPadding
		-- 	return string.rep(" ", leftPadding) .. text .. string.rep(" ", rightPadding)
		-- end
		--
		-- dashboard.section.footer.val = {
		-- 	centerText("Kaizoku Ou Ni Ore Wa Naru", 50),
		-- 	" ",
		-- 	-- centerText("NvimOnMy_Way❤️", 50),
		-- 	-- " ",
		-- 	centerText(date, 50),
		-- 	centerText(time, 50),
		-- 	centerText(version, 50),
		-- }

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		-- vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "alpha",
      callback = function()

        -- local opts = { buffer = true }
        vim.opt_local.foldenable = false
        vim.opt_local.modifiable = false
        vim.opt_local.readonly = true
        vim.opt_local.buftype = "nofile"
        vim.opt_local.bufhidden = "wipe"

        -- Disable key movements
        local keys = { "h", "j", "k", "l", "gg", "G", "<C-d>", "<C-u>", "<Up>", "<Down>", "<Left>", "<Right>", "n", "N", "/", "?", "w", "W", "b", "B", "e", "E", "f", "F", "t", "T" }
        for _, key in ipairs(keys) do
          vim.keymap.set("n", key, "<Nop>", { buffer = true })
        end
      end,
    })

	end,
}
