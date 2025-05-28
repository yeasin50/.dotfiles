return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-go",
    },
    config = function()
        local neotest = require("neotest")

        neotest.setup({
            adapters = {
                require("neotest-go")({
                    args = { "-count=1", "-v" },
                    experimental = {
                        test_table = true,
                    },
                }),
            },
        })

        -- Keymaps (same as vim-test style)
        local map = vim.keymap.set
        local opts = { desc = "Neotest", noremap = true, silent = true }

        map("n", "<leader>tn", function()
            vim.cmd("write")
            neotest.run.run()
        end, vim.tbl_extend("force", opts, { desc = "Run nearest test" }))

        map("n", "<leader>tf", function()
            vim.cmd("write")
            neotest.run.run(vim.fn.expand("%"))
        end, vim.tbl_extend("force", opts, { desc = "Run test file" }))

        map("n", "<leader>ts", function()
            vim.cmd("write")
            neotest.run.run(vim.loop.cwd())
        end, vim.tbl_extend("force", opts, { desc = "Run all tests (cwd)" }))

        map("n", "<leader>tl", neotest.run.run_last, vim.tbl_extend("force", opts, { desc = "Run last test" }))
        map("n", "<leader>tv", neotest.output_panel.toggle,
            vim.tbl_extend("force", opts, { desc = "Toggle output panel" }))
    end,
}
