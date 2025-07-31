local flutter_tools = require("flutter-tools")
local handlers = require("config.lsp.handlers")
local capabilities = require("config.lsp.capabilities").get()

flutter_tools.setup({
	lsp = {
		on_attach = handlers.on_attach,
		capabilities = capabilities,
		settings = {
			renameFilesWithClasses = "prompt",
			dart = {
				completeFunctionCalls = true,
				enableSnippets = true,
				showTodos = true,
			},
		},
	},
	widget_guides = {
		enabled = true,
	},
	closing_tags = {
		highlight = "Comment",
		prefix = "// ",
		enabled = true,
	},
})
