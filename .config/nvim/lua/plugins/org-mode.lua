return {
	-- {
	-- 	"lukas-reineke/headlines.nvim",
	-- 	dependencies = "nvim-treesitter/nvim-treesitter",
	-- 	config = true, -- or `opts = {}`
	-- },
	{
		"nvim-orgmode/orgmode",

		event = "VeryLazy",
		config = function()
			-- Load treesitter grammar for org
			require("orgmode").setup_ts_grammar()

			-- Setup orgmode
			require("orgmode").setup({
				org_agenda_files = "~/org/gtd/*",
				org_default_notes_file = "~/org/refile.org",
			})
		end,
	},
}
