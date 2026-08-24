local opt = vim.opt

-- Interface
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.showmode = false

-- Cursor
opt.guicursor = {
    "n-v-c:block",
    "i-ci-ve:block",
    "r-cr-o:block",
}

-- Indentation
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Windows
opt.splitright = true
opt.splitbelow = true

-- Scrolling
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Files
opt.swapfile = false
opt.backup = false
opt.undofile = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Completion
opt.completeopt = {
    "menu",
    "menuone",
    "noselect",
}

-- Appearance
opt.wrap = false
opt.laststatus = 3
opt.cmdheight = 1

-- Performance
opt.updatetime = 250
opt.timeoutlen = 400

-- Python provider used by Molten and other remote Python plugins.
vim.g.python3_host_prog =
    vim.fn.expand("~/.local/share/nvim/venv/bin/python")

-- Disable providers not used by this configuration.
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
