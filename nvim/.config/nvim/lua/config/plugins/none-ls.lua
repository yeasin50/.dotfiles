return {
	"nvimtools/none-ls.nvim",
	enabled = true,
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")
		local helpers = require("null-ls.helpers")

		function GetClassUnderCursor()
			print("aasdsdsd I")
			-- local ts = vim.treesitter
			-- local parsers = require("nvim-treesitter.parsers")
			--
			-- local bufnr = vim.api.nvim_get_current_buf()
			-- local lang = parsers.get_buf_lang(bufnr)
			--
			-- -- Get Tree-sitter parser and root node
			-- local parser = ts.get_parser(bufnr, lang)
			return nil
		end

		local insert_hello_action = {
			method = null_ls.methods.CODE_ACTION,
			filetypes = { "dart" },
			generator = {
				fn = function(params)
					return {
						{
							title = "CopyWith",
							action = function()
								GetClassUnderCursor()
							end,
						},
						-- {
						-- 	title = "toString",
						-- 	action = function()
						-- 		local row = params.range.start.line
						-- 		vim.api.nvim_buf_set_lines(0, row, row, false, { 'print("hello")' })
						-- 	end,
						-- },
					}
				end,
			},
		}

		null_ls.setup({
			sources = {
				insert_hello_action,
			},
		})
	end,
}
