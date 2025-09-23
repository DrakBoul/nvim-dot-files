-- LSP
vim.lsp.enable({ "lua_ls", "rust-analyzer", "clangd" })

-- Install Plugins
vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/stevearc/oil.nvim.git" },
    { src = "https://github.com/nvim-mini/mini.pick.git" },
    { src = "https://github.com/neovim/nvim-lspconfig.git" },
})

-- Setup Plugins
require 'mini.pick'.setup()
require 'oil'.setup()

-- Colorscheme
vim.cmd("colorscheme vague")

-- Keybinds
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>d', '<cmd>Oil<CR>')
vim.keymap.set('n', '<leader>sf', '<cmd>Pick files<CR>')
vim.keymap.set('n', '<leader>sb', '<cmd>Pick buffers<CR>')
vim.keymap.set('n', '<leader>sg', '<cmd>Pick grep<CR>')

-- Options
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.showmode = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

vim.opt.scrolloff = 30
vim.opt.scroll = 10

vim.opt.signcolumn = "yes"
vim.g.winborder = "rounded"
