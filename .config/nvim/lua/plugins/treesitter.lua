return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local config = require("nvim-treesitter.configs")
			config.setup({
        highlight = {enable = true},
        ensure_installed = {},
        ignore_install = {},
        sync_install = true,
        modules = {},
				auto_install = true,
				indent = { enable = true },
			})
		end,
	},
}
