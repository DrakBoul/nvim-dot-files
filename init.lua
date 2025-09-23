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
vim.cmd("set winborder=rounded")

-- LSP
vim.lsp.enable({ "lua_ls", "rust_analyzer", "clangd" })

-- Install Plugins
vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/stevearc/oil.nvim.git" },
    { src = "https://github.com/nvim-mini/mini.pick.git" },
    { src = "https://github.com/neovim/nvim-lspconfig.git" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
})

-- Setup Plugins
require("mini.pick").setup()
require("oil").setup()
require("nvim-treesitter.configs").setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "rust" },

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

-- Colorscheme
vim.cmd("colorscheme vague")

-- Keybinds
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>d', '<cmd>Oil<CR>')
vim.keymap.set('n', '<leader>sf', '<cmd>Pick files<CR>')
vim.keymap.set('n', '<leader>sb', '<cmd>Pick buffers<CR>')
vim.keymap.set('n', '<leader>sg', '<cmd>Pick grep<CR>')


