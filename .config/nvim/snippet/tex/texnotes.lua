local plenary = require("plenary")
local async = plenary.async

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node
local d = ls.dynamic_node
local sn = ls.snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local extras = require("luasnip.extras")
local rep = extras.rep

local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local function search_string_in_file(file_path, search_string)
  local file = assert(io.open(file_path, "r"))
  local found = false

  for line in file:lines() do
    if line:find(search_string, 1, true) then
      found = true
      break
    end
  end

  file:close()

  return found and file_path or nil
end

local function process_tex_files_async(folder_path, search_string)
  local files = {}
  for file in io.popen("fd .tex " .. folder_path):lines() do
    table.insert(files, file)
  end

  local results = {}
  local async_func = function()
    for _, file in ipairs(files) do
      local found_file = search_string_in_file(file, search_string)
      if found_file then
        table.insert(results, found_file)
      end
    end
  end

  async.run(async_func)
  return results
end

local search_string_in_files = function(dir, search_string)
  return process_tex_files_async(dir, search_string)
end

local uppercase = function(str)
  return string.gsub(" " .. str, "%W%l", string.upper):sub(2):gsub("[_ ]", "")
end

local remove_path = function(path)
  path = plenary.path:new(path):_split()
  return path[#path]
end

local get_RefName = function(string)
  local match = process_tex_files_async("~/texnotes/notes/slipbox", string)
  local ref = uppercase(remove_path(match[1]:sub(1, -5)))
  return ref
end

return {
  -- excref
  s(
    { trig = "([^%a])rf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta(
      [[
     <>\excref[<no>]{<yes>}
    ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        no = i(1),
        -- d(3, get_RefName(2))
        yes = i(2),
      }
    )
  ),

  -- exhyperref
  s(
    { trig = "([^%a])hrf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta(
      [[
     <>\exhyperref[<label>]{<RefName>}{<s>}
    ]],
      {
        f(function(_, snip)
          return snip.captures[1]
        end),
        label = i(1, "label"),
        RefName = i(2, "RefName"),
        s = i(3),
      }
    )
  ),
}
