return {
    {
        "saghen/blink.cmp",

        dependencies = {
            "saghen/blink.lib",
            "rafamadriz/friendly-snippets",
        },

        opts = {
            keymap = { preset = "super-tab" },

            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 300,
                },
            },

            signature = { enabled = true },

            sources = {
                default = {
                    "lsp",
                    "path",
                    "snippets",
                    "buffer",
                },
            },

            fuzzy = {
                implementation = "lua",
            },
        },
    },
}
