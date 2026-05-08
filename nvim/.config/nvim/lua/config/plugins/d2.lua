return {
	-- The Logic & Formatter (The "D2-vim" tool)
	{
		"terrastruct/d2-vim",
		ft = { "d2" },
		config = function()
			vim.g.d2_fmt_on_save = 1
		end,
	},
}
