return {
    "folke/zen-mode.nvim",
    opts = {
        window = {
            backdrop = 1,
            width = 100, -- Full width of focused buffer
            options = {
                number = false,
                relativenumber = false,
                signcolumn = "no",
            },
        },
        plugins = {
            tmux = { enabled = false },
            alacritty = { enabled = false },
            options = {
                enabled = true,
                laststatus = 0, -- Hide statusline
            },
        },
    },
    keys = {
        { "<leader>z", "<cmd>ZenMode<CR>", desc = "Toggle Zen Mode" },
    },
}
