return {
    {
        "chomosuke/typst-preview.nvim",
        lazy = false, -- or ft = 'typst'
        version = "1.*",
        opts = {}, -- lazy.nvim will implicitly calls `setup {}`
        config = function()
            require("typst-preview").setup()
        end,
    },
}
