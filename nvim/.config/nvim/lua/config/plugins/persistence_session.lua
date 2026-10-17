return {
	{
		"folke/persistence.nvim",
		lazy = false,
		opts = {},
		config = function(_, opts)
			require("persistence").setup(opts)

			vim.api.nvim_create_autocmd("VimEnter", {
				nested = true,
				callback = function()
					if vim.fn.argc() == 0 then
						require("persistence").load()
					end
				end,
			})
		end,
	},
}
