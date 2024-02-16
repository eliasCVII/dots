return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		-- Better surroundings, in visual or normal mode
		require("mini.surround").setup({
			mappings = {
				add = "S", -- Add surrounding in Normal and Visual modes
			},
		})

		-- Filesystem navigation+modifications
		require("mini.files").setup({
			windows = {
				-- Maximum number of windows to show side by side
				max_number = math.huge,
				-- Whether to show preview of file/directory under cursor
				preview = true,
				-- Width of focused window
				width_focus = 30,
				-- Width of non-focused window
				width_nofocus = 15,
				-- Width of preview window
				width_preview = 40,
			},
			mappings = {
				go_in = "l",
				go_in_plus = "<CR>",
			},
		})

		-- Jump around like a monkey
		require("mini.jump2d").setup({
			mappings = {
				start_jumping = "<CR>",
			},
		})

		-- Highlight stuff; hex colors #AA0000
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				-- Highlight hex color strings (`#rrggbb`) using that color
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})

		-- some out of the box settings
		require("mini.basics").setup({
			options = {
				basic = false,
				extra_ui = false,
				win_borders = "default",
			},
			mappings = {
				basic = false,
				option_toggle_prefix = "",
				windows = false,
				move_with_alt = true,
			},
			autocommands = {
				basic = false,
			},
		})

		-- Comments on gcc, gc
		require("mini.comment").setup({
			options = {
				ignore_blank_line = true,
			},
		})

		-- Beautiful indent scopes
		require("mini.indentscope").setup({})

		-- Extend f, F, t, T
		require("mini.jump").setup()

		-- Move selected blocks
		require("mini.move").setup({
			mappings = {
				-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
				left = "<M-h>",
				right = "<M-l>",
				down = "<M-j>",
				up = "<M-k>",

				-- Move current line in Normal mode
				line_left = "",
				line_right = "",
				line_down = "",
				line_up = "",
			},
		})

		-- gS
		require("mini.splitjoin").setup()

		require("mini.misc").setup()
		require("mini.misc").setup_restore_cursor()

		-- require("mini.starter").setup()
	end,
}

-- im trying stuff here alright? do you listen ? or not #aa0000, #dadada
