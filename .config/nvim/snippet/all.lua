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

is_even_line = function()
	local line_number = vim.fn["line"](".")
	if (line_number % 2) == 0 then -- an even-numbered line
		return true
	else -- an odd-numbered line
		return false
	end
end

-- test out some snippets here
return {
	-- \texttt
	-- s({ trig = "tt", dscr = "Expands 'tt' into '\texttt{}'" }, fmta("\\texttt{<>}", { i(1) })),
	-- Equation
	-- s(
	-- 	{ trig = "eq", dscr = "Expands 'eq' into an equation environment" },
	-- 	fmta(
	-- 		[[
	--         \begin{equation*}
	--             <>
	--         \end{equation*}
	--       ]],
	-- 		{ i(1) }
	-- 	)
	-- ),
	-- s(
	-- 	{ trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)" },
	-- 	fmta([[\href{<>}{<>}]], {
	-- 		i(1, "url"),
	-- 		i(2, "display name"),
	-- 	})
	-- ),
	-- s(
	-- 	{ trig = "tii", dscr = "Expands 'tii' into LaTeX's textit{} command.", snippetType = "autosnippet" },
	-- 	fmta("\\textit{<>}", {
	-- 		d(1, get_visual),
	-- 	})
	-- ),
}
