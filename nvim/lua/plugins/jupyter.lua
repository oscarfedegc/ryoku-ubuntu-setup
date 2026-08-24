return {
    {
        "goerz/jupytext.nvim",

        version = "0.2.0",
        lazy = false,

        opts = {
            format = "auto",
            update = true,
            autosync = true,
        },
    },

    {
        "benlubas/molten-nvim",

        version = "^1.0.0",
        build = ":UpdateRemotePlugins",

        init = function()
            vim.g.molten_auto_open_output = false
            vim.g.molten_virt_text_output = true
            vim.g.molten_virt_text_max_lines = 12
            vim.g.molten_output_win_max_height = 15
            vim.g.molten_image_provider = "none"
        end,

        config = function()
            local map = vim.keymap.set

            map("n", "<localleader>mi", "<cmd>MoltenInit<cr>", {
                desc = "Initialize Jupyter kernel",
            })

            map("n", "<localleader>rl", "<cmd>MoltenEvaluateLine<cr>", {
                desc = "Run line",
            })

            map("n", "<localleader>rr", "<cmd>MoltenReevaluateCell<cr>", {
                desc = "Re-run cell",
            })

            map("v", "<localleader>r", ":<C-u>MoltenEvaluateVisual<CR>gv", {
                desc = "Run selection",
            })

            map("n", "<localleader>os", "<cmd>MoltenShowOutput<cr>", {
                desc = "Show output",
            })

            map("n", "<localleader>oh", "<cmd>MoltenHideOutput<cr>", {
                desc = "Hide output",
            })
        end,
    },
}
