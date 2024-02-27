return {
	{
		"hrsh7th/nvim-cmp",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
			"windwp/nvim-ts-autotag",
			"windwp/nvim-autopairs",
			"micangl/cmp-vimtex",
		},
		config = function()
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			local refs = "~/texnotes/notes/documents.tex"
			local notes = "~/texnotes/notes/slipbox"
			local luasnip = require("luasnip")
			local lspkind = require("lspkind")

			require("nvim-autopairs").setup()

			-- Integrate nvim-autopairs with cmp
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			-- Load snippets
			-- require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippet/" })

			-- LuaSnip visual selection
			require("luasnip").config.set_config({ -- Setting LuaSnip config
				-- Use <Tab> (or some other key if you prefer) to trigger visual selection
				store_selection_keys = "<Tab>",
				enable_autosnippets = true,
			})

			-- : setup
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{
						name = "cmdline",
						option = {
							ignore_cmds = { "Man", "!" },
						},
					},
				}),
			})
			-- / setup
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
					["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-u>"] = cmp.mapping.scroll_docs(4), -- scroll up preview
					["<C-d>"] = cmp.mapping.scroll_docs(-4), -- scroll down preview
					["<C-Space>"] = cmp.mapping.complete({}), -- show completion suggestions
					["<C-c>"] = cmp.mapping.abort(), -- close completion window
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- select suggestion
				}),
				-- sources for autocompletion
				sources = cmp.config.sources({
					{ name = "nvim_lua", max_item_count = 10 },
					{ name = "nvim_lsp" }, -- lsp
					{ name = "luasnip", max_item_count = 3 }, -- snippets
					{ name = "buffer", max_item_count = 5 }, -- text within current buffer
					{ name = "path", max_item_count = 3 }, -- file system paths
					{ name = "vimtex" },
					{
						name = "texnotes",
						option = {
							path = refs,
							notes = notes,
						},
					},
				}),
				-- Enable pictogram icons for lsp/autocompletion
				formatting = {
					expandable_indicator = true,
					format = lspkind.cmp_format({
						with_text = true,
						mode = "symbol", -- "text_symbol"
						maxwidth = 50,
						ellipsis_char = "...",
						show_labelDetails = true,
						-- menu = {
						-- 	texnotes = "[TeXNotes]",
						-- },
					}),
				},

				experimental = {
					ghost_text = true,
				},
			})
		end,
	},
}
