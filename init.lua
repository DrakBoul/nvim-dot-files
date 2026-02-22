-- -- Options
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.o.relativenumber = true
vim.o.number = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.inccommand = 'split'
vim.o.incsearch = true
vim.o.cursorline = true
vim.o.showmode = true
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.mouse = ""                  -- no mouse
vim.o.guicursor = "a:block"
vim.o.grepprg = "rg --vimgrep -u" -- stop rg from searching hidden directories
vim.o.scrolloff = 30
vim.o.scroll = 10
vim.o.pumheight = 10
vim.o.pumborder = "rounded"
vim.o.wildmode = "noselect:lastused,full"
vim.o.wildoptions = "fuzzy"
vim.o.wildmenu = true
vim.o.completeopt = "fuzzy,menu,menuone,noinsert"

vim.lsp.enable({ "lua_ls", "rust_analyzer", "clangd", "pyright" })

-- -- Install plugins
vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/stevearc/oil.nvim.git" },
    { src = "https://github.com/neovim/nvim-lspconfig.git" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
    { src = "https://github.com/mason-org/mason.nvim.git" },
    { src = "https://github.com/nvim-lua/plenary.nvim.git" },
    { src = "https://github.com/sainnhe/everforest.git" },
})

-- Setup plugins
require('mason').setup()
require("oil").setup()
require("nvim-treesitter.configs").setup {
    -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    ensure_installed = { "c", "python", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "rust" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = false,

    -- List of parsers to ignore installing (or "all")
    ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {},
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
}

-- -- Colorscheme
vim.cmd("colorscheme everforest")

-- -- Keybinds
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>d', '<cmd>Oil<CR>')
vim.keymap.set('n', '<ESC><ESC>', '<cmd>nohlsearch<CR>')
-- Quick fix
vim.keymap.set('n', '<leader>q', '<cmd>copen<CR>')
vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>')
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>')
-- Tab pages
vim.keymap.set('n', '<leader>c', '<cmd>tabnew<CR>')
vim.keymap.set('n', '<leader>x', '<cmd>tabclose<CR>')
vim.keymap.set('n', '<leader>n', '<cmd>tabnext<CR>')
vim.keymap.set('n', '<leader>p', '<cmd>tabprev<CR>')
vim.keymap.set("n", "<leader>s", ":find ")

-- Commands
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- -- Diagnostics
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
})

-- -- Insert autocompletion

-- Make it so enter does not accept completion
vim.cmd("inoremap <expr> <CR> pumvisible() ? \"<C-e><CR>\" : \"<CR>\"")

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

-- -- Command line autocompletion
vim.cmd("autocmd CmdlineChanged [:\\/\\?] call wildtrigger()")

-- Remap left and right keys so they don't cycle completions in wildmenu
vim.cmd("cnoremap <expr> <Left>   wildmenumode() ? \"<C-E><Left>\"   : \"<Left>\"")
vim.cmd("cnoremap <expr> <Right> wildmenumode() ? \"<C-E><Right>\" : \"<Right>\"")

-- make keybind that mimics '*' but instead pumps it directly into grep and opens quickfix

-- -- Misc

-- Interactive find command with fuzzy finding
function _G.RgFindFiles(cmdarg, _cmdcomplete)
    local fnames = vim.fn.systemlist('rg --files --hidden --color=never --glob="!.git"')
    return #cmdarg == 0 and fnames or vim.fn.matchfuzzy(fnames, cmdarg)
end
vim.o.findfunc = 'v:lua.RgFindFiles'
