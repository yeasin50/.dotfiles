local M = {}

function M.on_attach(client, bufnr)
	local map = function(keys, func, desc, mode)
		mode = mode or "n"
		vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
	end

	map("<leader>gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")
	map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
	map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
	map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")
	map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")
	map("<leader>ws", require("fzf-lua").lsp_live_workspace_symbols, "[W]orkspace [S]ymbols")
	map("<leader>cr", vim.lsp.buf.rename, "[R]e[n]ame")
	map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
	map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

	-- Highlight references
	if client.supports_method("textDocument/documentHighlight") then
		local group = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = false })

		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = bufnr,
			group = group,
			callback = vim.lsp.buf.document_highlight,
		})

		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
			buffer = bufnr,
			group = group,
			callback = vim.lsp.buf.clear_references,
		})

		vim.api.nvim_create_autocmd("LspDetach", {
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.clear_references()
				vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
			end,
		})
	end

	-- Inlay hints
	if client.supports_method("textDocument/inlayHint") then
		map("<leader>th", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
		end, "[T]oggle Inlay [H]ints")
	end
end

return M
