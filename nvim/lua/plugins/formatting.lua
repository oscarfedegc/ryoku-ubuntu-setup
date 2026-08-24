return {
    {
        "stevearc/conform.nvim",

        event = { "BufWritePre" },
        cmd = { "ConformInfo" },

        keys = {
            {
                "<leader>f",

                function()
                    require("conform").format({
                        async = true,
                        lsp_format = "fallback",
                    })
                end,

                desc = "Format buffer",
            },
        },

        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_format" },
                c = { "clang_format" },
                cpp = { "clang_format" },
                tex = { "latexindent" },
            },

            format_on_save = function(bufnr)
                if vim.bo[bufnr].filetype == "tex" then
                    return
                end

                return {
                    timeout_ms = 1000,
                    lsp_format = "fallback",
                }
            end,
        },
    },
}
