return {
	{
		"folke/persistence.nvim",
		lazy = false, -- load at startup
		opts = {},

		config = function(_, opts)
			require("persistence").setup(opts)

			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					if vim.fn.argc() == 0 then
						vim.schedule(function()
							require("persistence").load()
						end)
					end
				end,
			})
		end,
	},
}
