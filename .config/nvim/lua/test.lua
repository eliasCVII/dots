-- Stolen from lualine
local current_git_dir = ''
local git_dir_cache = {} -- Stores git paths that we already know of
local sep = package.config:sub(1, 1)
local file_changed = sep ~= '\\' and vim.loop.new_fs_event() or vim.loop.new_fs_poll()

local function update_current_git_dir(git_dir)
  if current_git_dir ~= git_dir then
    current_git_dir = git_dir
  end
end

local function find_git_dir(dir_path)
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

