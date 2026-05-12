-- lua/config/run_file.lua
local M = {}

local Terminal = require("toggleterm.terminal").Terminal

-- reusable terminal (for C + Java)
local runner = Terminal:new({
	direction = "float",
	close_on_exit = false,
	float_opts = {
		border = "curved",
		width = math.floor(vim.o.columns * 0.9),
		height = math.floor(vim.o.lines * 0.4), -- half height
		row = math.floor(vim.o.lines * 0.5), -- start from middle (bottom half)
		col = math.floor(vim.o.columns * 0.05),
	},
})

local function run_in_terminal(cmd)
	runner:toggle()
	runner:send(cmd .. "\n")
end

---  For Curl in readme.md
local function get_custom_code_block()
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

	local start_row = row
	local found_start = false
	while start_row > 0 do
		--? Matches optional spaces, optional punctuation (//, #, --), then ```
		if lines[start_row]:match("^%s*%p*```") then
			found_start = true
			break
		end
		start_row = start_row - 1
	end

	if not found_start then
		return nil
	end

	--  Look DOWNWARDS from the start marker to find the end marker
	local end_row = start_row + 1
	local found_end = false
	while end_row <= #lines do
		if lines[end_row]:match("^%s*%p*```") then
			found_end = true
			break
		end
		end_row = end_row + 1
	end

	if not found_end then
		return nil
	end

	-- Ensure the cursor is actually inside this block
	if row < start_row or row > end_row then
		return nil
	end

	--  Extract only the lines INSIDE the block
	if end_row - start_row <= 1 then
		return nil
	end

	local block_lines = vim.list_slice(lines, start_row + 1, end_row - 1)
	local block_text = table.concat(block_lines, "\n")

	local vars = {}
	-- Scan from line 1 up to the start of the code block
	for i = 1, start_row - 1 do
		-- Looks for "@varName = value" or "@varName=value"
		local key, value = lines[i]:match("^@([%w_]+)%s*=%s*(.*)$")
		if key and value then
			vars[key] = value
		end
	end

	block_text = block_text:gsub("{{(.-)}}", function(key)
		key = key:match("^%s*(.-)%s*$") -- Trim spaces just in case user typed {{ var }}
		if vars[key] then
			return vars[key]
		else
			-- Warn the user if a variable is missing
			vim.notify("API snippet warning: Variable '" .. key .. "' not found!", vim.log.levels.WARN)
			return "{{" .. key .. "}}"
		end
	end)

	--  Squash into a single line to prevent terminal hanging
	-- Remove shell line-continuation backslashes and the newlines right after them
	block_text = block_text:gsub("\\%s*\n", " ")

	-- Aggressively convert ALL remaining newlines (like those inside JSON) into spaces
	block_text = block_text:gsub("\n", " ")

	-- Add a single "Enter" key trigger at the very end
	return block_text
end

-- Dart (Flutter Reload)
-- C(gcc) on mini floating terminal on bottom
-- Python(ManimPlay)
-- java run on mini floating terminal on bottom
-- .d2 render
function M.fileRunner()
	local ft = vim.bo.filetype
	local file = vim.fn.expand("%:p")
	local filename = vim.fn.expand("%:t:r")

	local curl_cmd = get_custom_code_block()

	if ft == "dart" or ft == "d2" or curl_cmd ~= nil then
		local terms = require("toggleterm.terminal").get_all()
		if #terms == 0 then
			vim.notify("⚠️ No terminal running", vim.log.levels.WARN)
			return
		end
		if curl_cmd ~= nil then
			terms[1]:send(curl_cmd)
			vim.notify("🔥 Sent curl")
		elseif ft == "dart" then
			terms[1]:send("r\n")
			vim.notify("🔥 Sent hot reload to Flutter terminal")
		elseif ft == "d2" then
			local input = file
			local output = vim.fn.expand("%:p:r") .. ".svg"

			local cmd = "d2 "
				.. vim.fn.shellescape(input)
				.. " "
				.. vim.fn.shellescape(output)
				.. " --watch --sketch --layout=elk --theme=200"

			terms[1]:open()
			terms[1]:send(cmd .. "\n")

			vim.notify("🎬 D2 watching...")
		end

	---  Theses run on mini terminal
	elseif ft == "c" then
		local cmd = string.format("gcc '%s' -o '%s' && ./'%s'", file, filename, filename)
		run_in_terminal(cmd)
		vim.notify("⚙️ Compiling and running C file...")
	elseif ft == "java" then
		-- run single-file Java (Java 11+)
		local cmd = string.format("java '%s' 2>/dev/null", file)
		run_in_terminal(cmd)
		vim.notify("☕ Running Java...")
	elseif ft == "python" then
		vim.cmd("ManimPlay")
		vim.notify("🎬 Running ManimPlay command...")
	elseif is_curl_block() then
		----done inside block
	else
		vim.notify("❌ Unsupported filetype: " .. ft)
	end
end

return M
