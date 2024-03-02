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
  -- Automatic generic environments
  s(
    { trig = "env", snippetType = "autosnippet" },
    fmta(
      [[
        \begin{<>}
            <>
        \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1), -- this node repeats insert node i(1)
      }
    )
  ),

  -- Hyperref
  s(
    { trig = "href", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[\hyperref[<>]{<>}]], {
      i(1),
      i(2),
    })
  ),

  -- Wrap visual selection into some environment
  -- Section
  s(
    { trig = "sec", dscr = "Expands 'sec' into LaTeX's section{} command." },
    fmta("\\section{<>}", {
      d(1, get_visual),
    })
  ),

  -- emph
  s(
    { trig = "em([^%a])", dscr = "Expands 'em' into LaTeX's emph{} command." },
    fmta("\\emph{<>}", {
      d(1, get_visual),
    })
  ),

  s(
    { trig = "dcc", snippetType = "autosnippet" },
    fmta(
      [=[
        \documentclass[<>]{<>}
        ]=],
      {
        i(1, "a4paper"),
        i(2, "article"),
      }
    ),
    { condition = line_begin }
  ),

  -- \usepackage
  s(
    { trig = "pack", snippetType = "autosnippet" },
    fmta(
      [[
        \usepackage{<>}
        ]],
      {
        d(1, get_visual),
      }
    ),
    { condition = line_begin }
  ),

  -- INPUT a LaTeX file
  s(
    { trig = "inn", snippetType = "autosnippet" },
    fmta(
      [[
      \input{<><>}
      ]],
      {
        i(1, "~/texnotes/notes/slipbox/"),
        i(2),
      }
    ),
    { condition = line_begin }
  ),
  -- LABEL
  s(
    { trig = "lbl", snippetType = "autosnippet" },
    fmta(
      [[
      \label{<>}
      ]],
      {
        d(1, get_visual),
      }
    )
  ),

  -- URL
  s(
    { trig = "url" },
    fmta([[\url{<>}]], {
      d(1, get_visual),
    })
  ),

  -- SECTION
  s({ trig = "h1", snippetType = "autosnippet" },
    fmta(
      [[\section{<>}]],
      {
        d(1, get_visual),
      }
    )
  ),
  -- SUBSECTION
  s({ trig = "h2", snippetType = "autosnippet" },
    fmta(
      [[\subsection{<>}]],
      {
        d(1, get_visual),
      }
    )
  ),
  -- SUBSUBSECTION
  s({ trig = "h3", snippetType = "autosnippet" },
    fmta(
      [[\subsubsection{<>}]],
      {
        d(1, get_visual),
      }
    )
  ),
}
