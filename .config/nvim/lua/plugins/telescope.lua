return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>.", builtin.find_files, {})
			vim.keymap.set("n", "<leader>tg", builtin.live_grep, {})

			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		lazy = true,
		config = function()
			require("telescope").load_extension("frecency")
		end,
	},
}
