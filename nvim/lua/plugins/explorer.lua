return {
    {
        "nvim-tree/nvim-tree.lua",

        config = function()
            require("nvim-tree").setup({
                view = { width = 32 },

                renderer = {
                    group_empty = true,
                    icons = {
                        show = {
                            file = false,
                            folder = false,
                            folder_arrow = false,
                            git = false,
                            modified = false,
                            diagnostics = false,
                            bookmarks = false,
                        },
                    },
                },

                filters = { dotfiles = false },
            })

            vim.keymap.set(
                "n",
                "<leader>e",
                "<cmd>NvimTreeToggle<cr>",
                { desc = "File explorer" }
            )
        end,
    },
}
