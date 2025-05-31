
-- Map leader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set relative line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- Configure White Space
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true

-- Clear search highlighting using escape
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Open Netrw
vim.keymap.set('n', '<Leader>d', '<cmd>Ex<CR>', {desc = 'Open Netrw'})

-- Shortcut for entering normal mode
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('t', 'jk', '<C-\\><C-n>')

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

-- Terminal
local termbuf = nil
local visible = false
local termwidth = vim.api.nvim_win_get_width(0)
local termheight = vim.api.nvim_win_get_height(0)
local termopts = {relative='win', row=0, col=0, width=termwidth, height=termheight}

function ToggleTerm()
    if termbuf == nil and not visible then
        termbuf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_open_win(termbuf, true, termopts)
        vim.api.nvim_win_set_buf(0, termbuf)
        vim.cmd("term")
        vim.cmd("startinsert")
        visible = true
    elseif termbuf ~= nil and not visible then
        vim.api.nvim_open_win(termbuf, true, termopts)
        visible = true
        vim.cmd("startinsert")
    elseif termbuf ~= nil and visible then
        vim.api.nvim_win_set_buf(0, 1)
        -- assumes term is the current window
        vim.api.nvim_win_hide(0)
        visible = false
    else
        print("Terminal buffer is nil but still visible! Nonsense!")
    end
end

function SendLastCmd()
    if termbuf == nil then
        print("Terminal has not been created yet!")
    end
    if not visible then
        ToggleTerm()
    end

end

vim.keymap.set({'n', 't'}, '<M-k>', function ()
    ToggleTerm()
end, {desc = "Toggle Terminal"})


function ExecLastCmd()
    if termbuf == nil then
        print("No terminal session started!")
        return
    end
    vim.api.nvim_open_win(termbuf, true, termopts)
    visible = true
    local ch = vim.bo.channel
    vim.cmd("startinsert")
    -- Escape sequence moves cursor up and does carriage return
    vim.api.nvim_chan_send(ch, '\x1B[A\r')
end

vim.keymap.set('n', '<leader>l', function ()
    ExecLastCmd()
end, {desc = "Open terminal, and Execute last command"})

vim.keymap.set('n', '<leader>b', function ()
    ExecCommand("cargo build")
end, {desc = "Cargo Test"})

function ExecCommand(cmd)
    if termbuf == nil then
        print("No terminal session started!")
        return
    end
    vim.api.nvim_open_win(termbuf, true, termopts)
    visible = true
    local ch = vim.bo.channel
    vim.cmd("startinsert")
    -- Escape sequence moves cursor up and does carriage return
    local formatted_cmd = cmd .."\n"
    vim.api.nvim_chan_send(ch, formatted_cmd)
end






