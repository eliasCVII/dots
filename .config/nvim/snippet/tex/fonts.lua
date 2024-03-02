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

-- Math context detection
local tex = {}
tex.in_mathzone = function()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
  return not tex.in_mathzone()
end

return {
  -- TYPEWRITER i.e. \texttt
  s(
    { trig = "([^%a])tt", regTrig = true, wordTrig = false, snippetType = "autosnippet", priority = 2000 },
    fmta("<>\\texttt{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_text }
  ),
  -- ITALIC i.e. \textit
  s(
    { trig = "([^%a])tii", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\textit{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- BOLD i.e. \textbf
  s(
    { trig = "tbb", snippetType = "autosnippet" },
    fmta("\\textbf{<>}", {
      d(1, get_visual),
    })
  ),
  -- MATH ROMAN i.e. \mathrm
  s(
    { trig = "([^%a])rmm", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\mathrm{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),

  -- MATH CALIGRAPHY i.e. \mathcal
  s(
    { trig = "([^%a])mcc", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\mathcal{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),

  -- MATH BOLDFACE i.e. \mathbf
  s(
    { trig = "([^%a])mbf", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\mathbf{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),

  s(
    { trig = "tin", dscr = "Expands 'tin' into LaTeX's textnormal{} command.", snippetType = "autosnippet" },
    fmta("\\textnormal{<>}", {
      d(1, get_visual),
    })
  ),

  -- MATH BLACKBOARD i.e. \mathbb
  s(
    { trig = "([^%a])mbb", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\mathbb{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    })
  ),
  -- REGULAR TEXT i.e. \text (in math environments)
  s(
    { trig = "([^%a])tee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>\\text{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone }
  ),
}
