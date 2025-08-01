
-- Map leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- Set relative line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Configure White Space
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4


vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.showmode = true

vim.schedule(function()
vim.o.clipboard = 'unnamedplus'
end)


vim.keymap.set('i','jk', '<Esc>')

-- Clear search highlighting using escape
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Open Oil.nvim
vim.keymap.set('n', '<Leader>d', '<cmd>Oil<CR>', {desc = 'Open Oil'})

-- Shortcut to jump between windows
vim.keymap.set('n','<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')

-- Diagnostics Keymaps
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, {desc = 'Open [Q]uick Fix List'})



-- nvim docs --
-- lua api help
vim.keymap.set('n', '<Leader>hl', '<cmd>vs /usr/share/nvim/runtime/doc/lua.txt<CR>', {desc = '[H]elp for [L]ua'})
vim.keymap.set('n', '<Leader>hp', '<cmd>vs /usr/share/nvim/runtime/doc/lsp.txt<CR>', {desc = '[H]elp for LS[P]'})
vim.keymap.set('n', '<Leader>ho', '<cmd>vs /usr/share/nvim/runtime/doc/quickref.txt<CR>', {desc = '[H]elp for [O]ptions'})


-- Telescope keybinds
vim.keymap.set('n', '<leader>sf', '<cmd>Telescope find_files<CR>', { desc = '[s]earch [f]iles' })
vim.keymap.set('n', '<leader>sg', '<cmd>Telescope live_grep<CR>', { desc = '[s]earch live [g]rep' })
vim.keymap.set('n', '<leader>sb', '<cmd>Telescope buffers<CR>', { desc = '[s]earch [b]uffers' })
vim.keymap.set('n', '<leader>sh', '<cmd>Telescope help_tags<CR>', { desc = '[s]earch [h]elp' })
vim.keymap.set('n', '<leader>sc', '<cmd>Telescope colorscheme<CR>', { desc = '[s]earch [c]olor schemes' })

-- Sourcing Files
vim.keymap.set('n', '<leader>x', '<cmd>so %<CR>', {desc = 'Source Current File'})

-- Tab Pages
vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = 'Open New Tab' })
vim.keymap.set('n', '<leader>tc', '<cmd>tabclose<CR>', { desc = 'Close Current Tab' })
vim.keymap.set('n', '<leader>tl', '<cmd>tabnext<CR>', { desc = 'Goto Next Tab' })
vim.keymap.set('n', '<leader>th', '<cmd>tabprevious<CR>', { desc = 'Goto Previous Tab' })

-- Quick Fix
vim.keymap.set('n', '<leader>cj', '<cmd>cnext<CR>', {desc = 'Goto Next Quick Fix'})
vim.keymap.set('n', '<leader>ck', '<cmd>cprev<CR>', {desc = 'Goto Previous Quick Fix'})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})



