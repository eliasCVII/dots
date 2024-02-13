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
	-- Text in math mode
	s(
		{ trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command.", snippetType = "autosnippet" },
		fmta("\\textit{<>}", {
			d(1, get_visual),
		})
	),

	s(
		{ trig = "tin", dscr = "Expands 'tin' into LaTeX's textnormal{} command.", snippetType = "autosnippet" },
		fmta("\\textnormal{<>}", {
			d(1, get_visual),
		})
	),

	-- Frac
	s(
		{ trig = "([^%a])ff", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[<>\frac{<>}{<>}]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
			i(2),
		})
	),

	-- Bold input in math mode
	s(
		{ trig = "([^%a]).,", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
		fmta([[<>\mathbf{<>}]], {
			f(function(_, snip)
				return snip.captures[1]
			end),
			i(1),
		})
	),
}
