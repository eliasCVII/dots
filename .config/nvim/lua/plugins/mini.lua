return {
	"echasnovski/mini.nvim",
	event = "VeryLazy",
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
				width_preview = 55,
			},
			mappings = {
				go_in = "l",
				go_in_plus = "<CR>",
			},
		})

		-- Jump around like a monkey
		-- require("mini.jump2d").setup({
		-- 	mappings = {
		-- 		start_jumping = "<CR>",
		-- 	},
		-- })

		-- Highlight stuff; hex colors #AA0000
		local hipatterns = require("mini.hipatterns")

		local words = { -- Change to filetype?
			Part = "#ea83a5",
			Chapter = "#ea83a5",
		}

		local word_color_group = function(_, match)
			local hex = words[match]
			if hex == nil then
				return nil
			end
			return MiniHipatterns.compute_hex_color_group(hex, "bg")
		end

		hipatterns.setup({
			highlighters = {
				-- Highlight hex color strings (`#rrggbb`) using that color
				hex_color = hipatterns.gen_highlighter.hex_color(),
				word_color = { pattern = "%S+", group = word_color_group },
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

		-- Great picker for anything
		local win_config = function()
			local height = 20
			local width = 70
			return {
				config = {
					anchor = "NW",
					height = height,
					width = width,
					row = math.floor(0.5 * vim.o.lines - (height / 2)),
					col = math.floor(0.5 * (vim.o.columns - width)),
				},
				prompt_prefix = " : ",
			}
		end
		require("mini.pick").setup({
      window = win_config()
    })
		local pick = require("mini.pick")
		pick.registry.buffers = function(local_opts)
			local wipeout_func = function()
				vim.api.nvim_buf_delete(pick.get_picker_matches().current.bufnr, {})
				pick.stop()
				vim.cmd("Pick buffers")
			end
			pick.builtin.buffers(local_opts, { mappings = { wipeout = { char = "<C-d>", func = wipeout_func } } })
		end

		-- Bracket movement
		require("mini.bracketed").setup() -- TODO: learn mappings

		-- Visited files
		require("mini.visits").setup() -- replace telescope frecency/ spc-fr?

		-- Remove whitespace
		require("mini.trailspace").setup()

		-- Extra features
		require("mini.extra").setup()
	end,
}
