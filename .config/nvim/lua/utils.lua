local U = {}

U.texnote_setup = function() -- run the whole texnotes setup
	-- dont know why vim treats .tex files differently
	vim.filetype.add({
		extension = {
			tex = "tex",
		},
	})

	-- run on texnotes folder only?
	local expand = vim.fn.expand
	local dir = "~/notes/texnotes"
	if vim.loop.cwd() == expand(dir) then
		require("texnotes")
		require("texnotes-watcher")
	end
end

U.wrap = function() -- wrap on stuff that aint for coding
	vim.api.nvim_create_autocmd("BufEnter", {
		group = vim.api.nvim_create_augroup("wrapper", { clear = true }),
		pattern = { "*.tex", "*.md", "*.org", "*.typ" },
		callback = function()
			vim.wo.wrap = true
			vim.wo.linebreak = true
		end,
	})
end

U.toggle_colorcolumn = function() -- toggle colorcolumn on and off
	local default_value = { 80 }
	local value = vim.inspect(vim.opt.colorcolumn:get())
	if value == "{}" then
		vim.opt.colorcolumn = default_value
	else
		vim.opt.colorcolumn = {}
	end
end

return U
