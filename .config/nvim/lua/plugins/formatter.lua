-- return { -- inserts tabs...
-- 	"stevearc/conform.nvim",
-- 	opts = {},
-- 	config = function()
-- 		require("conform").setup({
-- 			formatters_by_ft = {
-- 				lua = { "stylua" },
-- 				python = { "black", "isort" },
-- 			},
-- 			format_on_save = {
-- 				timeout_ms = 500,
-- 				lsp_fallback = true,
-- 			},
-- 		})
-- 	end,
-- }

-- return { -- weird shit happens
-- "elentok/format-on-save.nvim",
-- config = function()
--   local format_on_save = require("format-on-save")
--   local formatters = require("format-on-save.formatters")

--   format_on_save.setup({
--     experiments = {
--       partial_update = "diff",
--     },
--     exclude_path_patterns = {
--       "/node_modules/",
--       ".local/share/nvim/lazy",
--     },
--     formatter_by_ft = {
--       lua = formatters.lsp,
--       cpp = formatters.lsp,
--       c = formatters.lsp,
--       markdown = formatters.lsp,

--       my_custom_formatter = function()
--         if vim.api.nvim_buf_get_name(0):match("/README.md$") then
--           return formatters.prettierd
--         else
--           return formatters.lsp()
--         end
--       end,

--       python = {
--         -- formatters.remove_trailing_whitespace,
--         formatters.black,
--         formatters.isort,
--       },
--     },
--   })
--   require("format-on-save").restore_cursors()
-- end,
-- }

-- return { -- sucks ass
--   "lukas-reineke/lsp-format.nvim",
--   config = function()
--     require("lsp-format").setup({})

--     local on_attach = function(client, bufnr)
--       require("lsp-format").on_attach(client, bufnr)

--       -- ... custom code ...
--     end
--     require("lspconfig").lua_ls.setup({ on_attach = on_attach })
--   end,
-- }
--
return {}
