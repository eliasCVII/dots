local api = vim.api

local render = function(name)
  local file = name:sub(1,-5)
  print("rendering ...", name)
  vim.fn.jobstart({"python", "manage.py", "render", file})
end

local render_on_save = function(filename)
  vim.api.nvim_create_autocmd('BufWritePost', {
      group = vim.api.nvim_create_augroup('watcher', { clear = true }),
      pattern = "*.tex",
      callback = function()
        render(filename)
      end,
  })
end

vim.api.nvim_create_user_command("Render", function()
  local buf = api.nvim_get_current_buf()
  local path = api.nvim_buf_get_name(buf)
  local name = path:match(".+/([^/]+)$")
  render_on_save(name)
end, {})


local dir="~/texnotes/"

vim.api.nvim_create_user_command("Viewer", function()
  local buf = api.nvim_get_current_buf()
  local path = api.nvim_buf_get_name(buf)
  local name = path:match(".+/([^/]+)$"):sub(1,-5)
  local file = dir.."pdf/"..name..".pdf"
  print("we on", file)
  vim.fn.jobstart({"handlr", "open", file})
end, {})
