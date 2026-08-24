return {
    {
        "ibhagwan/fzf-lua",

        config = function()
            local fzf = require("fzf-lua")

            fzf.setup({
                winopts = {
                    border = "rounded",
                    preview = { border = "rounded" },
                },
            })

            vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })
            vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })
            vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
            vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Help" })
        end,
    },
}
