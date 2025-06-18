 
local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.md",
    callback = function()
      local buf = vim.api.nvim_get_current_buf()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local content = table.concat(lines, "\n")

      for link in content:gmatch("%[%[([%w%-%_/%s]+)%]%]") do
        local current_file = vim.api.nvim_buf_get_name(0)
        local current_dir = vim.fn.fnamemodify(current_file, ":h")
        local filename = vim.fn.trim(link):gsub("%s+", "_") .. ".md"
        local path = current_dir .. "/" .. filename

        if vim.fn.filereadable(path) == 0 then
          local f = io.open(path, "w")
          if f then
            f:write("# " .. link .. "\n")
            f:close()
            vim.notify("Created: " .. path, vim.log.levels.INFO)
          else
            vim.notify("Failed to create: " .. path, vim.log.levels.ERROR)
          end
        end
      end
    end,
  })
end

return M
