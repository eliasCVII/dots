-- Improve code workflow
return {

	{ -- highlight TODO:comments
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},

	{
		"folke/trouble.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufEnter",
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup({
				scope = {
					enabled = true,
					show_start = false,
					show_end = false,
				},
			})
		end,
	},
}
