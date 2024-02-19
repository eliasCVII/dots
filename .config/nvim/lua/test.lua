function Uppercase(str)
	return string.gsub(" " .. str, "%W%l", string.upper):sub(2):gsub("[_ ]", "")
end

function Lowercase(str)
	return string.gsub(" " .. str, "%w%l", string.lower):sub(2):gsub("[ ]", "_")
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

-- if cwd ~= dir then
-- 	print("not where we should be")
-- end

local function get_tag()
	local output = vim.fn.system("timew")
	local pre_tags, total_time
	local lines = {}

	for line in output:gmatch("[^\r\n]+") do
		table.insert(lines, line)
	end

	if #lines > 1 then
		pre_tags = lines[1]
		if pre_tags:find('"') then
			pre_tags = lines[1]:match('"([^"]*)"')
		else
			pre_tags = lines[1]:match("Tracking%s*(%S+%s*%S+)")
		end

		local tags = {}
		if pre_tags:find(" ") then
			for tag in pre_tags:gmatch("%S+") do
				table.insert(tags, tag)
			end
		end

		total_time = lines[4]:match("%d+:%d+:%d+")
		local hours, minutes, seconds = total_time:match("(%d+):(%d+):(%d+)")
		local formatted_time = string.format("%02d:%02d", hours, minutes)
		return tags
		-- return " " .. tag .. " - " .. formatted_time
	end
end

local tags = get_tag()
print(tags[2])
