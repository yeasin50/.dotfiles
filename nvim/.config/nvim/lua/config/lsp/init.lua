local M = {}

function M.setup()
	local lspconfig = require("lspconfig")
	local handlers = require("config.lsp.handlers")
	local capabilities = require("config.lsp.capabilities").get()

	-- Language-specific configs
	local servers = {
		lua_ls = require("config.lsp.servers.lua_ls"),
		gopls = require("config.lsp.servers.gopls"),
		marksman = require("config.lsp.servers.marksman"),
	}

	-- Ensure mason installs servers
	local ensure_installed = vim.tbl_keys(servers)
	vim.list_extend(ensure_installed, {
		"stylua", -- Lua formatter
		"prettier",
	})

	require("mason").setup()
	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
	require("mason-lspconfig").setup({
		automatic_installation = false,
		handlers = {
			function(server_name)
				local server_opts = servers[server_name] or {}
				server_opts.capabilities =
					vim.tbl_deep_extend("force", {}, capabilities, server_opts.capabilities or {})
				server_opts.on_attach = handlers.on_attach
				lspconfig[server_name].setup(server_opts)
			end,
		},
	})

	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true }),
		callback = function(event)
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client then
				require("config.lsp.handlers").on_attach(client, event.buf)
			end
		end,
	})

	-- Diagnostic UI setup (you already had this)
	vim.diagnostic.config({
		severity_sort = true,
		float = { border = "rounded", source = "if_many" },
		underline = { severity = vim.diagnostic.severity.ERROR },
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "󰅚 ",
				[vim.diagnostic.severity.WARN] = "󰀪 ",
				[vim.diagnostic.severity.INFO] = "󰋽 ",
				[vim.diagnostic.severity.HINT] = "󰌶 ",
			},
		},
		virtual_text = {
			source = "if_many",
			spacing = 2,
			format = function(diagnostic)
				return diagnostic.message
			end,
		},
	})
end

return M
