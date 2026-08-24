return {
    {
        "mason-org/mason-lspconfig.nvim",

        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {},
            },

            "neovim/nvim-lspconfig",
            "saghen/blink.cmp",
        },

        opts = {
            ensure_installed = {
                "basedpyright",
                "ruff",
                "texlab",
                "lua_ls",
            },
        },

        config = function(_, opts)
            local capabilities =
                require("blink.cmp").get_lsp_capabilities()

            vim.lsp.config("basedpyright", {
                capabilities = capabilities,

                settings = {
                    python = {
                        pythonPath = vim.fn.exepath("python"),
                    },

                    basedpyright = {
                        analysis = {
                            typeCheckingMode = "standard",
                            diagnosticMode = "openFilesOnly",
                        },
                    },
                },
            })

            vim.lsp.config("ruff", {
                capabilities = capabilities,

                on_attach = function(client)
                    client.server_capabilities.hoverProvider = false
                end,
            })

            vim.lsp.config("texlab", {
                capabilities = capabilities,
            })

            vim.lsp.config("lua_ls", {
                capabilities = capabilities,

                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },

                        workspace = {
                            checkThirdParty = false,
                        },

                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            require("mason-lspconfig").setup(opts)

            vim.lsp.config("clangd", {
                capabilities = capabilities,

                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--completion-style=detailed",
                },
            })

            vim.lsp.enable("clangd")

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(event)
                    local function map(lhs, rhs, desc)
                        vim.keymap.set(
                            "n",
                            lhs,
                            rhs,
                            {
                                buffer = event.buf,
                                desc = desc,
                            }
                        )
                    end

                    map("gd", vim.lsp.buf.definition, "Go to definition")
                    map("gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("gr", vim.lsp.buf.references, "References")
                    map("K", vim.lsp.buf.hover, "Documentation")
                    map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
                end,
            })

            vim.diagnostic.config({
                severity_sort = true,

                virtual_text = {
                    spacing = 2,
                    prefix = "●",
                },

                float = {
                    border = "rounded",
                    source = true,
                },

                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "E",
                        [vim.diagnostic.severity.WARN] = "W",
                        [vim.diagnostic.severity.INFO] = "I",
                        [vim.diagnostic.severity.HINT] = "H",
                    },
                },
            })
        end,
    },
}
