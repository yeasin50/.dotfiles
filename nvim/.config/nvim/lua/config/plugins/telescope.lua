return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    enabled= false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
  
      telescope.setup({
        defaults = {
          layout_strategy = "horizontal",
          layout_config = {
            preview_width = 0.6,
          },
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
            },
          },
        },
      })
  
      -- Optional: keymaps
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
    end,
  }
  
