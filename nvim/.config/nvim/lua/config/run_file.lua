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

-- Dart (Flutter Reload)
-- C(gcc) on mini floating terminal on bottom
-- Python(ManimPlay)
-- java run on mini floating terminal on bottom
--
function M.fileRunner()
	local ft = vim.bo.filetype
	local file = vim.fn.expand("%:p")
	local filename = vim.fn.expand("%:t:r")

	if ft == "dart" then
		local terms = require("toggleterm.terminal").get_all()
		if #terms == 0 then
			vim.notify("⚠️ No Flutter terminal running", vim.log.levels.WARN)
			return
		end
		terms[1]:send("r\n")
		vim.notify("🔥 Sent hot restart to Flutter terminal")
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
	else
		vim.notify("❌ Unsupported filetype: " .. ft)
	end
end

return M
