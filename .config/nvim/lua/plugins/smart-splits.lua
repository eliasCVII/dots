return {
	"mrjones2014/smart-splits.nvim",
	lazy = false,
	config = function()
		require("smart-splits").setup({
			ignored_filetypes = {
				"nofile",
				"quickfix",
				"prompt",
			},
			-- Ignored buffer types (only while resizing)
			ignored_buftypes = { "NvimTree" },
			-- the default number of lines/columns to resize by at a time
			default_amount = 5,
		})
		vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
		vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
		vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
		vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
	end,
}
