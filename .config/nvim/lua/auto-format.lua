vim.api.nvim_create_autocmd("BufWritePost", {
	group = vim.api.nvim_create_augroup("autoformat", { clear = true }),
	callback = function()
		-- vim.lsp.buf.format({ async = true })
		vim.lsp.buf.format()
	end,
})
