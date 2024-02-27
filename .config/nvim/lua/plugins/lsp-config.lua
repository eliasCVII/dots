return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
		},
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls", "pyright" },
				handlers = {
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup({})
					end,
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		lazy = false,
	},
}
