local api = vim.api

function GetFileName()
	local buf = api.nvim_get_current_buf()
	local path = api.nvim_buf_get_name(buf)
	local name = path:match(".+/([^/]+)$")
	return name
end

local name = GetFileName()
-- print("we cookin inside " .. name)

-- api.nvim_create_autocmd("BufEnter", {
--   command = "Render"
-- })
--
-- vim.g.maplocalleader = ","
