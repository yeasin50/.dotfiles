local M = {}

function M.get()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	return require("blink.cmp").get_lsp_capabilities(capabilities)
end

return M
