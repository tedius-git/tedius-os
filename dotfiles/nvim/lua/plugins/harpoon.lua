return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
                key = function()
                    return vim.loop.cwd()
                end,
            },
        })

        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
        vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

        -- Keybindings
        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Harpoon: Add file" })
        vim.keymap.set("n", "<leader>h", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        vim.keymap.set("n", "<A-h>", function()
            harpoon:list():select(1)
        end, { desc = "harpoon open file 1" })

        vim.keymap.set("n", "<A-j>", function()
            harpoon:list():select(2)
        end, { desc = "harpoon open file 2" })

        vim.keymap.set("n", "<A-k>", function()
            harpoon:list():select(3)
        end, { desc = "harpoon open file 3" })

        vim.keymap.set("n", "<A-l>", function()
            harpoon:list():select(4)
        end, { desc = "harpoon open file 4" })
    end,
}
