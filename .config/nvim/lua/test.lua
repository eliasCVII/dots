function Uppercase(str)
  return string.gsub(" "..str, "%W%l", string.upper):sub(2):gsub("[_ ]","")
end

function Lowercase(str)
  return string.gsub(" "..str, "%w%l", string.lower):sub(2):gsub("[ ]","_")
end

-- vim.ui.input(
--   { prompt = "enter some word: " },
--   function(input)
--     input = Uppercase(input)
--     print(input)
--   end)

local dir = "/home/elias/texnotes"

-- vim.ui.input(
--   { prompt = "enter some word: " },
--   function(input)
--     input = Lowercase(input)
--     print("creating", input .. ".tex")
--     --Manage("newnote", input)
--     input = input..".tex"
--     vim.defer_fn(function()
--       -- OpenFile(input, dir.."notes/slipbox/")
--       -- print(input, dir)
--     end, 200)
--     print(input)
--   end)

local cwd = vim.loop.cwd()

if cwd ~= dir then
  print("not where we should be")
end
