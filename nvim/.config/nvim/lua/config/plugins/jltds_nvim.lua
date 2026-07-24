return {
	"mfussenegger/nvim-jdtls",
	ft = "java", -- Only load this plugin when you open a Java file
	config = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = function()
				local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
				local workspace_dir = vim.fn.expand("~/.local/share/eclipse/") .. project_name

				require("jdtls").start_or_attach({
					cmd = { "jdtls", "-data", workspace_dir },
					root_dir = require("jdtls.setup").find_root({
						".git",
						"mvnw",
						"gradlew",
						"pom.xml",
						"build.gradle",
					}),
				})
			end,
		})
	end,
}
