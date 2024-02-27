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

	-- ref
	-- s(
	-- 	{ trig = "ref([^%a])", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
	-- 	fmta([[\ref{<>:<>}]], {
	-- 		-- f(function(_, snip)
	-- 		-- 	return snip.captures[1]
	-- 		-- end),
	-- 		i(1),
	-- 		i(2),
	-- 	})
	-- ),

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
}
