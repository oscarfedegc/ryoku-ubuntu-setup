local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    local repo = "https://github.com/folke/lazy.nvim.git"

    local output = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        repo,
        lazypath,
    })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to install lazy.nvim:\n", "ErrorMsg" },
            { output, "WarningMsg" },
        }, true, {})

        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        { import = "plugins" },
    },

    install = {
        colorscheme = { "ryoku" },
    },

    checker = {
        enabled = false,
    },

    change_detection = {
        notify = false,
    },

    rocks = {
        enabled = false,
    },
})
