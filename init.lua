-- Leader key
vim.g.mapleader = " "

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"
vim.g.treesitter_ensure_installed = {} -- now treated as "all" instead of {}

-- 1. BOOTSTRAP LAZY.NVIM (Corrected Code)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    print("Installing lazy.nvim....")
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- 2. SETUP PLUGINS
require("lazy").setup({

    -- LSP
    { "neovim/nvim-lspconfig" },

    -- Autocomplete
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },

    -- Snippets
    { "L3MON4D3/LuaSnip" },

    -- Command suggestions
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup()
        end,
    },

    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    -- Mason
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },

    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- Git signs
    { "lewis6991/gitsigns.nvim" },

    -- Trouble
    { "folke/trouble.nvim" },

    -- Statusline
    { "nvim-lualine/lualine.nvim" },

    -- Auto pairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },

    -- Treesitter

    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        build = ':TSUpdate'
    },
    -- leetcode
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html_tags", -- if you have `nvim-treesitter` installed
        dependencies = {
            -- include a picker of your choice, see picker section for more details
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            -- configuration goes here
        },
    },

    -- windserf codeium
    {
        'Exafunction/windsurf.vim',
        event = 'BufEnter'
    },

    -- Theme:
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
    }
})

-- Load custom config only if it exists
pcall(require, "config")
