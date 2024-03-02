local U = {}

U.menu_mappings = function(...)
  local mappings = {

    choose = "<CR>",
    choose_in_split = "",
    choose_in_vsplit = "",
    choose_marked = "<C-o>",

    delete_left = "",
    delete_word = "<C-u>",

    mark = "<C-x>",
    mark_all = "",

    move_up = "<C-k>",
    move_down = "<C-j>",
    move_start = "",

    paste = "",

    refine = "",
    refine_marked = "",

    scroll_up = "<C-f>",
    scroll_down = "<C-b>",
    scroll_left = "<C-h>",
    scroll_right = "<C-l>",

    toggle_info = "",
    toggle_preview = "<Tab>",
  }

  for _, param in ipairs({ ... }) do
    for key, value in pairs(param) do
      mappings[key] = value
    end
  end

  return mappings
end

U.win_config = function()
  local height = 20
  local width = 70
  return {
    config = {
      anchor = "NW",
      height = height,
      width = width,
      row = math.floor(0.5 * vim.o.lines - (height / 2)),
      col = math.floor(0.5 * (vim.o.columns - width)),
    },
    prompt_prefix = " : ",
  }
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

U.autoformat = function()
  vim.lsp.buf.format()
  MiniTrailspace.trim()
  vim.cmd("retab")
  vim.cmd("write")
  vim.cmd("normal! zz")
end

return U
