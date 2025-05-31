return {
    "kylechui/nvim-surround",
    version = "*", -- use the latest
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({})
    end,
}


-- 📝 Default Key Mappings:
-- NORMAL mode:
--   ys<motion><char>   → add surrounding      (e.g., ysiw" → "word")
--   ds<char>           → delete surrounding   (e.g., ds" → word)
--   cs<old><new>       → change surrounding   (e.g., cs"' → 'word')

-- VISUAL mode:
--   S<char>            → surround selection   (e.g., select word, then S) → (word)

-- "motion" refers to a movement like `iw` (inner word), `as` (a sentence), etc.

-- TIP: Try typing `:h nvim-surround` in Neovim for full documentation.
