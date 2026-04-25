return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
	},

	config = function()
		local dap = require("dap")
		local dapgo = require("dap-go")

		-- Setup dap-go (auto debug support)
		dapgo.setup({
			delve = {
				port = 2345,
			},
		})

		-- 🔥 Remote attach (for: make debug)
		dap.configurations.go = {
			{
				type = "go",
				name = "Attach (Delve :2345)",
				request = "attach",
				mode = "remote",
				host = "127.0.0.1",
				port = 2345,
			},
			{
				type = "go",
				name = "Debug (auto)",
				request = "launch",
				program = "${file}",
			},
		}

		-- ✅ Keymaps
		vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
		vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })

		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>B", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Conditional Breakpoint" })

		vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Debug: Restart" })
		vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Debug: Quit" })

		-- Optional: log (helpful if things break)
		vim.keymap.set("n", "<leader>dl", function()
			require("dap").set_log_level("DEBUG")
			print("DAP log level set to DEBUG")
		end)
	end,
}
