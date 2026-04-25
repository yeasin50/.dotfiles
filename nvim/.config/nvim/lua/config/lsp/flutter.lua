local flutter_tools = require("flutter-tools")
local handlers = require("config.lsp.handlers")
local capabilities = require("config.lsp.capabilities").get()
local util = require("lspconfig.util")

flutter_tools.setup({
	lsp = {
		on_attach = function(client, bufnr)
			handlers.on_attach(client, bufnr)
		end,

		capabilities = capabilities,

		root_dir = function(fname)
			-- Prioritize the melos workspace root or git root FIRST.
			-- Only fall back to pubspec.yaml if it's not a mono-repo.
			return util.root_pattern("melos.yaml", ".git")(fname) or util.root_pattern("pubspec.yaml")(fname)
		end,

		settings = {
			renameFilesWithClasses = "prompt",
			dart = {
				completeFunctionCalls = true,
				enableSnippets = true,
				showTodos = true,
				-- CRITICAL FOR PERFORMANCE
				analysisExcludedFolders = {
					"build",
					".dart_tool",
					util.path.join(vim.fn.expand("$HOME"), ".pub-cache"),
				},
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
