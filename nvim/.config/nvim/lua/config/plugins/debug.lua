return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"leoluz/nvim-dap-go",
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},

	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("dap-go").setup()

		dapui.setup()

		-- Go debug configurations
		dap.configurations.go = {
			-- Attach to Delve started manually:
			-- dlv debug . --headless --listen=:40000 --api-version=2 --accept-multiclient
			{
				type = "go",
				name = "Attach Delve :40000",
				request = "attach",
				mode = "remote",
				host = "127.0.0.1",
				port = 40000,
			},

			-- Normal local debug
			{
				type = "go",
				name = "Launch current file",
				request = "launch",
				program = "${file}",
			},

			-- Launch from cmd directory
			{
				type = "go",
				name = "Launch Server (from cmd)",
				request = "launch",
				program = function()
					return vim.fn.input("Path to main package: ", vim.fn.getcwd() .. "/cmd/")
				end,
			},
		}

		-- Open UI when debugging starts
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end

		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end

		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- Keymaps
		vim.keymap.set("n", "<F5>", dap.continue, {
			desc = "Debug: Start/Continue",
		})

		vim.keymap.set("n", "<F10>", dap.step_over, {
			desc = "Debug: Step Over",
		})

		vim.keymap.set("n", "<F11>", dap.step_into, {
			desc = "Debug: Step Into",
		})

		vim.keymap.set("n", "<F12>", dap.step_out, {
			desc = "Debug: Step Out",
		})

		vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, {
			desc = "Debug: Toggle Breakpoint",
		})

		vim.keymap.set("n", "<leader>du", dapui.toggle, {
			desc = "Debug: Toggle UI",
		})

		vim.keymap.set({ "n", "v" }, "<leader>de", function()
			dapui.eval()
		end, {
			desc = "Debug: Evaluate",
		})
	end,
}
