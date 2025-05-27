return
{
    "vim-test/vim-test",
    keys = {
        { "<leader>tn", ":TestNearest<CR>", desc = "Run nearest Go test" },
        { "<leader>tf", ":TestFile<CR>",    desc = "Run all tests in current Go file" },
        { "<leader>ts", ":TestSuite<CR>",   desc = "Run full Go test suite" },
        { "<leader>tl", ":TestLast<CR>",    desc = "Re-run last test" },
    },
    config = function()
        vim.g["test#strategy"] = "neovim" -- or "toggleterm", "basic", "vimterminal"
    end,
}
