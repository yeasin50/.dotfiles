-- maybe in Future

-------
local ts_utils = require("nvim-treesitter.ts_utils")
local ts_query = require("vim.treesitter.query")

local lang = "dart"

--- Gets the root node of the current buffer
local function get_root()
	local parser = vim.treesitter.get_parser(0, lang)
	local tree = parser:parse()[1]
	return tree:root()
end

--- Finds the first class node in the current buffer
local function get_class_node(root)
	for node in root:iter_children() do
		if node:type() == "class_definition" then
			return node
		end
	end
end

--- Gets the name of the class from the class node
local function get_class_name(class_node)
	local name_node = class_node:field("name")[1]
	return ts_utils.get_node_text(name_node, 0)[1]
end

--- Extracts class fields using Treesitter query
local function get_class_fields(class_node)
	local query_string = [[
(class_definition
  body: (class_body
    (declaration
      (type_identifier) @type
      (initialized_identifier_list
        (initialized_identifier
          (identifier) @fieldName)))))
]]

	local query = ts_query.parse(lang, query_string)
	local root = get_root()

	for id, node in query:iter_captures(root, 0, 0, -1) do
		local name = query.captures[id]
		if name == "fieldName" then
			local text = vim.treesitter.get_node_text(node, 0)
			print("Found field: " .. text)
		end
	end
end

function _G.copyWith()
	local parser = vim.treesitter.get_parser(0, "dart")
	local root = parser:parse()[1]:root()

	local class_node = get_class_node(root)
	if not class_node then
		vim.notify("No class found in file", vim.log.levels.ERROR)
		return
	end

	local class_name = get_class_name(class_node)
	local fields = get_class_fields(class_node)

	print(vim.inspect(fields))
	-- vim.notify("copyWith() added for " .. class_name)
end
--

vim.keymap.set("n", "<leader>rr", function()
	vim.cmd("source $MYVIMRC")

	vim.defer_fn(function()
		if type(copyWith) == "function" then
			copyWith()
		else
			vim.notify("copyWith() is not defined after reload", vim.log.levels.ERROR)
		end
	end, 50)
end, { desc = "Reload init.lua and run copyWith()" })
