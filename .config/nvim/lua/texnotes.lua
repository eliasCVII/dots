-- Making the TeXNotes workflow faster...
-- setup to work on BufWritePost
-- right now the entries dont get updated

local api = vim.api

local dir = "~/texnotes/"

function Uppercase(str)
	return string.gsub(" " .. str, "%W%l", string.upper):sub(2):gsub("[_ ]", "")
end

function Lowercase(str)
	return string.gsub(" " .. str, "%w%l", string.lower):sub(2):gsub("[ ]", "_")
end

function GetPath(pattern) -- Get list of *.tex or *.pdf files
	local directory = dir
	if pattern == "tex" then -- only look for .tex files inside the slipbox folder
		directory = "~/texnotes/notes/slipbox"
	end
	local files = vim.fs.find(function(name)
		return name:match(".*%." .. pattern .. "$")
	end, { limit = math.huge, type = "file", path = directory })
	return files
end

function RemovePath(path) -- returns the filename only, i.e index.tex
	return path:match(".+/([^/]+)$")
end

local pdfs = GetPath("pdf")
local tex = GetPath("tex")

function OpenFile(name, path)
	-- Open the .tex files
	print(path .. name)
	local found = vim.fn.filereadable(vim.fn.expand(path .. name))
	if found == 1 then
		vim.cmd("e " .. path .. name)
	else
		print("file not found")
	end
end

function Manage(command, par_one, par_two) -- control manage.py
	vim.fn.jobstart({ "python", "manage.py", command, par_one, par_two })
end

function EditNote()
	tex = GetPath("tex")
	vim.ui.select(tex, { prompt = "choose note to edit" }, function(choice)
		if choice ~= nil then
			local name = RemovePath(choice)
			local path = dir .. "notes/slipbox/"
			-- print("you what bro")
			-- vim.defer_fn(function()
			--   print("i... I dont know")
			-- end, 500)
			OpenFile(name, path)
		end
		return choice
	end)
end

function RenderNote() -- render a specific note
	tex = GetPath("tex")
	vim.ui.select(tex, { prompt = "choose note to render" }, function(choice)
		if choice ~= nil then
			local name = RemovePath(choice):sub(1, -5)
			print("rendering", name)
			Manage("render", name)
			vim.defer_fn(function()
				vim.fn.jobstart({ "handlr", "open", dir .. "pdf/" .. name .. ".pdf" })
			end, 500)
		end
		return choice
	end)
end

function DeleteFile()
	-- kind of a dangereous function
	tex = GetPath("tex")
	vim.ui.select(tex, { prompt = "choose note to delete" }, function(choice)
		if choice ~= nil then
			local name = RemovePath(choice):sub(1, -5)
			local command = "!bash auto_delete.sh " .. name
			vim.ui.input({ prompt = "Deleting " .. name .. ", you sure? (y/n) " }, function(input)
				if input == "y" then
					vim.cmd(command)
				else
					return
				end
				local delete_everything = vim.fn.input("Delete compiled files?: (y/n) ")
				if delete_everything == "y" then
					vim.cmd(command .. " y")
				end
			end)
		end
		return choice
	end)
end

function NewNote()
	vim.ui.input({ prompt = "new: " }, function(input)
		input = Lowercase(input) -- replace " " with "_"
		print("creating", input .. ".tex")
		Manage("newnote", input)
		input = input .. ".tex"
		vim.defer_fn(function()
			OpenFile(input, dir .. "notes/slipbox/")
		end, 200)
	end)
end

function ViewNote()
	pdfs = GetPath("pdf")
	vim.ui.select(pdfs, { prompt = "choose compiled note to view" }, function(choice)
		if choice ~= nil then
			local name = RemovePath(choice)
			print("opening", name)
			vim.fn.jobstart({ "handlr", "open", choice })
		end
		return choice
	end)
end

function RenameNote()
	tex = GetPath("tex")
	vim.ui.select(tex, { prompt = "choose a note to rename" }, function(choice)
		if choice ~= nil then
			local rename = vim.fn.input("rename: ")
			local name = RemovePath(choice):sub(1, -5)
			print("renaming", name)
			Manage("rename_file", name, rename)
		end
		return choice
	end)
end

function RenameReference()
	tex = GetPath("tex")
	vim.ui.select(tex, { prompt = "choose a reference to rename" }, function(choice)
		if choice ~= nil then
			local name = Uppercase(RemovePath(choice):sub(1, -5))
			print("renaming", name)
			vim.ui.input({ prompt = "rename: " }, function(input)
				input = Uppercase(input)
				Manage("rename_reference", name, input)
			end)
		end
		return choice
	end)
end

function OpenGraph()
	Manage("synchronize", "")
	vim.defer_fn(function()
		vim.fn.jobstart({ "python", "network.py" })
	end, 400)
end

local options = {
	"render",
	"new",
	"rename",
	"rename_ref",
	"delete",
	"view",
	"graph",
	"edit",
}

-- Menu for Notes
api.nvim_create_user_command("Note", function(opts)
	selection = opts.fargs[1]

	-- Set a filewatcher on a .tex file
	if selection == options[1] then
		RenderNote()

	-- Adding notes to the slipbox
	elseif selection == options[2] then
		NewNote()

	-- Rename a selected note
	elseif selection == options[3] then
		RenameNote()

	-- Rename a reference
	elseif selection == options[4] then
		RenameReference()

	-- Removing notes
	elseif selection == options[5] then
		-- delete doesnt work right now
		DeleteFile()

	-- Launching pdf viewer
	elseif selection == options[6] then
		ViewNote()

	-- Open the network view
	elseif selection == options[7] then
		OpenGraph()

	-- Launch a list of .tex notes to edit
	elseif selection == options[8] then
		EditNote()
	end
end, {
	nargs = 1,
	complete = function(ArgLead, CmdLine, CursorPos)
		-- return completion candidates as a list-like table
		return options
	end,
})

api.nvim_create_autocmd("BufEnter", {
	pattern = "*.tex",
	callback = function()
		vim.cmd("Render")
	end,
	-- command = "Render"
})
