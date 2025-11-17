-- lua/config/run_file.lua
local M = {}

local Terminal = require("toggleterm.terminal").Terminal

-- Dart (Flutter Reload)
-- C(gcc)
-- Python(ManimPlay)
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
		-- local cmd = string.format("gcc '%s' -o '%s' && ./'%s'", file, filename, filename)
		-- local term = Terminal:new({ cmd = cmd, close_on_exit = false, direction = "float" })
		-- term:toggle()
		-- vim.notify("⚙️ Compiling and running C file...")

		local Terminal = require("toggleterm.terminal").Terminal
		local file = vim.fn.expand("%:p")
		local filename = vim.fn.expand("%:t:r")
		local cmd = string.format("gcc '%s' -o '%s' && ./'%s'", file, filename, filename)

		local term = Terminal:new({
			cmd = cmd,
			close_on_exit = false,
			direction = "float",
			float_opts = {
				border = "curved",
				width = math.floor(vim.o.columns * 0.9),
				height = math.floor(vim.o.lines * 0.4), -- half height
				row = math.floor(vim.o.lines * 0.5), -- start from middle (bottom half)
				col = math.floor(vim.o.columns * 0.05),
			},
		})
		term:toggle()
		vim.notify("⚙️ Compiling and running C file...")
	elseif ft == "python" then
		vim.cmd("ManimPlay")
		vim.notify("🎬 Running ManimPlay command...")
	else
		vim.notify("❌ Unsupported filetype: " .. ft)
	end
end

return M
