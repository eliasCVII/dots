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
		config = function()
			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			-- local lspconfig = require("lspconfig")

			-- lspconfig.lua_ls.setup({
			-- 	capabilities = capabilities,
			-- })
			-- lspconfig.pyright.setup({})
			-- lspconfig.bashls.setup({})
			-- lspconfig.clangd.setup({})

			-- vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			-- vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			-- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			-- vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
