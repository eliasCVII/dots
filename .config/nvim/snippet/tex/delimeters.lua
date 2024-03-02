local line_begin = require("luasnip.extras.expand_conditions").line_begin
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

return {
  -- LEFT/RIGHT PARENTHESES
  s(
    { trig = "([^%a])l%(", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\left(<>\\right)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- LEFT/RIGHT SQUARE BRACES
  s(
    { trig = "([^%a])l%[", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\left[<>\\right]", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- LEFT/RIGHT CURLY BRACES
  s(
    { trig = "([^%a])l%{", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\left\\{<>\\right\\}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- BIG PARENTHESES
  s(
    { trig = "([^%a])b%(", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\big(<>\\big)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- BIG SQUARE BRACES
  s(
    { trig = "([^%a])b%[", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\big[<>\\big]", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- BIG CURLY BRACES
  s(
    { trig = "([^%a])b%{", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\big\\{<>\\big\\}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- ESCAPED CURLY BRACES
  s(
    { trig = "([^%a])\\%{", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
    fmta("<>\\{<>\\}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- LATEX QUOTATION MARK
  s(
    { trig = "``", snippetType = "autosnippet" },
    fmta("``<>''", {
      d(1, get_visual),
    })
  ),
}
