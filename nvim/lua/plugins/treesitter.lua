return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",

        config = function()
            local treesitter = require("nvim-treesitter")

            treesitter.setup()

            treesitter.install({
                "bash",
                "c",
                "cpp",
                "json",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
                "toml",
                "vim",
                "vimdoc",
                "yaml",
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "bash",
                    "c",
                    "cpp",
                    "json",
                    "lua",
                    "markdown",
                    "python",
                    "toml",
                    "vim",
                    "yaml",
                },

                callback = function(args)
                    pcall(vim.treesitter.start, args.buf)
                end,
            })
        end,
    },
}
