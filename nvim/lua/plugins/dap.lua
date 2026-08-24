return {
    {
        "mfussenegger/nvim-dap",

        dependencies = {
            "mfussenegger/nvim-dap-python",

            {
                "rcarriga/nvim-dap-ui",

                dependencies = {
                    "nvim-neotest/nvim-nio",
                },
            },
        },

        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup({
                controls = {
                    enabled = false,
                },

                icons = {
                    expanded = "v",
                    collapsed = ">",
                    current_frame = "*",
                },
            })

            local mason_bin =
                vim.fn.stdpath("data") .. "/mason/bin/"

            require("dap-python").setup(
                mason_bin .. "debugpy-adapter"
            )

            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",

                executable = {
                    command = mason_bin .. "codelldb",

                    args = {
                        "--port",
                        "${port}",
                    },
                },
            }

            dap.configurations.cpp = {
                {
                    name = "Launch executable",
                    type = "codelldb",
                    request = "launch",

                    program = function()
                        return vim.fn.input(
                            "Executable: ",
                            vim.fn.getcwd() .. "/",
                            "file"
                        )
                    end,

                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }

            dap.configurations.c = dap.configurations.cpp

            vim.keymap.set("n", "<F5>", dap.continue, {
                desc = "Debug continue",
            })

            vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, {
                desc = "Toggle breakpoint",
            })

            vim.keymap.set("n", "<F10>", dap.step_over, {
                desc = "Step over",
            })

            vim.keymap.set("n", "<F11>", dap.step_into, {
                desc = "Step into",
            })

            vim.keymap.set("n", "<F12>", dap.step_out, {
                desc = "Step out",
            })

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end

            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end

            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end

            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
}
