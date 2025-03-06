return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    opts = {},
    config = function()
        local fzf = require("fzf-lua")
        fzf.setup({
            keymap = {
                fzf = {
                    ["ctrl-q"] = "select-all+accept",
                },
            },
        })
        vim.keymap.set("n", "<leader><leader>", ":FzfLua files<CR>")
        vim.keymap.set("n", "<leader>/", ":FzfLua blines<CR>")
        vim.keymap.set("n", "<leader>gr", ":FzfLua live_grep<CR>")
        vim.keymap.set("n", "<leader>gc", ":FzfLua git_commits<CR>")
        vim.keymap.set("n", "<leader>fz", ":FzfLua builtin<CR>")
    end,
}
