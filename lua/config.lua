vim.cmd.colorscheme("catppuccin-mocha")
-- Mason

require("mason").setup()

require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "clangd", "pyright" },
})

-- Autocomplete capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- NEW Neovim built-in LSP config system
local servers = { "lua_ls", "clangd", "pyright" }

for _, server in ipairs(servers) do
    vim.lsp.config(server, {
        capabilities = capabilities,
    })
    vim.lsp.enable(server)
end

-- Autocomplete setup
local cmp = require("cmp")

cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
    }
})

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local opts = { buffer = args.buf }

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    end,
})

-- Auto format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format()
    end,
})

-- Better diagnostics
vim.diagnostic.config({
    virtual_text = true,
    float = { border = "rounded" },
})

-- File explorer
require("nvim-tree").setup()
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- Git signs
require("gitsigns").setup()

-- Statusline
require("lualine").setup({
    options = { theme = "auto" }
})

-- Trouble
require("trouble").setup()
vim.keymap.set("n", "<leader>x", ":TroubleToggle<CR>")

--
vim.g.treesitter_ensure_installed = {} -- now treated as "all" instead of {}
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"


-- VSCode-style popup suggestions
local cmp = require("cmp")

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "cmdline" },
        { name = "path" },
    },
})


-- Enable LSP inlay hints automatically
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
        end
    end,
})

-- Move line up/down in normal mode
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })

-- Move selected lines in visual mode
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })
