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
  local pattern = { "*.tex", "*.md", "*.org", "*.typ" }
  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*", -- Matches all files not in the specified patterns
    callback = function()
      vim.wo.wrap = false
    end,
  })
  vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("wrapper", { clear = true }),
    pattern = pattern,
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

U.toggle_numbers = function()
  local value = vim.wo.nu
  if value then
    vim.opt.rnu = false
    vim.opt.nu = false
  else
    vim.opt.rnu = true
    vim.opt.nu = true
  end
end

U.autoformat = function()
  vim.lsp.buf.format()
  MiniTrailspace.trim()
  vim.cmd("retab")
  vim.cmd("write")
  vim.cmd("normal! zz")
end

U.on_save = function()
  MiniTrailspace.trim()
  vim.cmd("write")
end

U.tabline = function()
  function Tabline()
    local tabline = ""

    for tab = 1, vim.fn.tabpagenr("$") do
      local win = vim.fn.tabpagewinnr(tab)
      local buf = vim.fn.tabpagebuflist(tab)[win]
      local bufname = vim.fn.bufname(buf)

      tabline = tabline .. (tab == vim.fn.tabpagenr() and "%#TabLineSel#" or "%#TabLine#")

      local bufModified = vim.fn.getbufvar(buf, "&mod")
      local tabName = " "

      if bufModified == 1 then
        tabName = "*" .. vim.fn.fnamemodify(bufname, ":t") .. " "
      else
        tabName = vim.fn.fnamemodify(bufname, ":t") .. " "
      end

      tabline = tabline .. (bufname ~= "" and tabName or "untitled ")
    end

    return " " .. tabline
  end

  vim.o.tabline = "%!v:lua.Tabline()"
end

U.apply_indent = function()
  local buf = vim.api.nvim_get_current_buf()
  local lnum = vim.api.nvim_win_get_cursor(0)[1]

  local line = vim.api.nvim_buf_get_lines(buf, lnum - 1, lnum, false)[1]
  if line ~= "" then
    return
  end

  -- get indent from indentexpr (Tree-sitter or fallback)
  local old_lnum = vim.v.lnum
  vim.v.lnum = lnum
  local indent = vim.fn.eval(vim.bo.indentexpr)
  vim.v.lnum = old_lnum

  if indent > 0 then
    vim.api.nvim_buf_set_lines(
      buf,
      lnum - 1,
      lnum,
      false,
      { string.rep(" ", indent) }
    )
  end
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("$", true, false, true), "n",
    true)
end

U.browser_sync = function()
  vim.fn.jobstart(
    { 'browser-sync', 'start', '--proxy', 'localhost:8080', '--files', '**/*.php' },
    {
      on_stdout = function(chanid, data, name)
        vim.notify(vim.inspect(data), vim.log.levels.INFO)
      end,
      on_stderr = function(chanid, data, name)
        vim.notify(vim.inspect(data), vim.log.levels.WARN)
      end,
      on_exit = function(id, exitcode, event)
        vim.notify(vim.inspect(exitcode))
      end,
    }
  )
end

-- Check if we are inside a git dir
local current_git_dir = ''
local git_dir_cache = {} -- Stores git paths that we already know of
local sep = package.config:sub(1, 1)
local file_changed = sep ~= '\\' and vim.loop.new_fs_event() or vim.loop.new_fs_poll()

local function update_current_git_dir(git_dir)
  if current_git_dir ~= git_dir then
    current_git_dir = git_dir
  end
end

U.find_git_dir = function(dir_path)
  local git_dir = vim.env.GIT_DIR
  if git_dir then
    update_current_git_dir(git_dir)
    return git_dir
  end

  -- get file dir so we can search from that dir
  local file_dir = dir_path or vim.fn.expand('%:p:h')

  if package.loaded.oil then
    local oil = require('oil')
    local ok, dir = pcall(oil.get_current_dir)
    if ok and dir and dir ~= '' then
      file_dir = vim.fn.fnamemodify(dir, ':p:h')
    end
  end

  -- extract correct file dir from terminals
  if file_dir and file_dir:match('term://.*') then
    file_dir = vim.fn.expand(file_dir:gsub('term://(.+)//.+', '%1'))
  end

  local root_dir = file_dir
  -- Search upward for .git file or folder
  while root_dir do
    if git_dir_cache[root_dir] then
      git_dir = git_dir_cache[root_dir]
      break
    end
    local git_path = root_dir .. sep .. '.git'
    local git_file_stat = vim.loop.fs_stat(git_path)
    if git_file_stat then
      if git_file_stat.type == 'directory' then
        git_dir = git_path
      elseif git_file_stat.type == 'file' then
        -- separate git-dir or submodule is used
        local file = io.open(git_path)
        if file then
          git_dir = file:read()
          git_dir = git_dir and git_dir:match('gitdir: (.+)$')
          file:close()
        end
        -- submodule / relative file path
        if git_dir and git_dir:sub(1, 1) ~= sep and not git_dir:match('^%a:.*$') then
          git_dir = git_path:match('(.*).git') .. git_dir
        end
      end
      if git_dir then
        local head_file_stat = vim.loop.fs_stat(git_dir .. sep .. 'HEAD')
        if head_file_stat and head_file_stat.type == 'file' then
          break
        else
          git_dir = nil
        end
      end
    end
    root_dir = root_dir:match('(.*)' .. sep .. '.-')
  end

  git_dir_cache[file_dir] = git_dir
  if dir_path == nil then
    update_current_git_dir(git_dir)
  end
  return git_dir
end

U.set_transparent = function() -- set UI component to transparent
  local groups = {
    "Normal",
    "NormalNC",
    "EndOfBuffer",
    "NormalFloat",
    "FloatBorder",
    "SignColumn",
    "StatusLine",
    "StatusLineNC",
    "TabLine",
    "TabLineFill",
    "TabLineSel",
    "ColorColumn",
  }
  for _, g in ipairs(groups) do
    vim.api.nvim_set_hl(0, g, { bg = "none" })
  end
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = "none", fg = "#767676" })
end

return U
