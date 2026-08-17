return {
	"echasnovski/mini.statusline",
	version = "*",
	config = function()
		local MiniStatusline = require("mini.statusline")

		MiniStatusline.setup({
			use_icons = true,
		})

		MiniStatusline.section_filename = function()
			local file = vim.fn.expand("%:t")
			local parent = vim.fn.expand("%:h:t")

			if file == "" then
				return "[No Name]"
			end

			if parent == "." then
				return file
			end

			return parent .. "/" .. file
		end
	end,
}
