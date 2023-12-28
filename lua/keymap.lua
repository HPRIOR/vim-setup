local M = {}

-- utils
local function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

local function nmap(shortcut, command)
    map("n", shortcut, command)
end

local function vmap(shortcut, command)
    map("v", shortcut, command)
end


M.bind_keys_general = function()
    -- clipboard copy visual selection below
    vmap("<C-p>", "y'>p")
    -- default mapping for formatting
    nmap("gf", ":Format<cr>")
    -- LazyGit integration
    nmap("<leader>vg", ":LazyGit<CR>")
    -- spell checking
    nmap("<C-s>", ":setlocal spell! spelllang=en_gb<CR>")
    -- GPT
    nmap("<C-c>", ":ChatGPT<CR>")
    vmap("<C-c>", ":ChatGPT<CR>")
    -- Rust
    nmap("<leader>vr", "<cmd>lua require('rust-tools.runnables').runnables()<CR>")
    -- Window window management
    nmap("<leader>h", "<c-w>h")
    nmap("<leader>l", "<c-w>l")
    nmap("<leader>k", "<c-w>k")
    nmap("<leader>j", "<c-w>j")
    nmap("=", ":vertical resize +5<CR>")
    nmap("-", ":vertical resize -5<CR>")
    nmap("+", ":resize +5<CR>")
    nmap("_", ":resize -5<CR>")
    nmap("<leader>=", "<c-w>=")
    vmap("<C-a>", "<cmd>Telescope gpt<cr>")
    nmap("<C-a>", "<cmd>Telescope gpt<cr>")
end


-- called in lua/telescope.lua
M.bind_telescope = function()
    return {
        { "<leader>:", "<cmd>Telescope command_history<cr>",               desc = "Command history" },
        { "<leader>;", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>",     desc = "Buffer" },
        -- todo: jump history instead?
        { "<leader>'", "<cmd>Telescope marks<cr>",                         desc = "Jump to Mark" },
        { "<leader>f", "<cmd>Telescope find_files<cr>",                    desc = "Find files" },
        { "<leader>g", "<cmd>Telescope live_grep<cr>",                     desc = "Live grep" },
        { "<leader>n", "<cmd>Telescope notify<cr>",                        desc = "Live grep" },
        {
            "<leader>z",
            "<cmd>lua require'telescope.builtin'.lsp_document_symbols()<cr>",
            desc = "Lsp symbols"
        },

        {
            "<leader>b",
            "<cmd>lua require'telescope.builtin'.builtin(require('telescope.themes').get_dropdown({ width = 0.8, previewer = false, prompt_title = false }))<cr>",
            desc = "Built ins",
        },
        {
            "gd",
            "<cmd>lua require'telescope.builtin'.lsp_definitions()<cr>",
            desc = "Go to definition",
        },
        {
            "gu",
            "<cmd>lua require'telescope.builtin'.lsp_references()<cr>",
            desc = "References",
        },
        -- diagnostics in current buffer
        {
            "<leader>xx",
            "<cmd>lua require'telescope.builtin'.diagnostics({ bufnr = 0 })<cr>", -- todo change severity
            desc = "Diagnostics",
        },
        -- diagnostics for all buffers
        {
            "<leader>xa",
            "<cmd>lua require'telescope.builtin'.diagnostics()<cr>", -- todo change severity
            desc = "Diagnostics",
        },
        {
            "<leader>s",
            "<cmd>lua require'telescope.builtin'.spell_suggest(require('telescope.themes').get_dropdown({ width = 0.8, previewer = false, prompt_title = false }))<cr>",
            desc = "Spell check",
        },
    }
end

-- todo not sure about this really
M.bind_cmp = function()
    local cmp = require('cmp')
    return {
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }
end


-- called in lua/lsp.lua
-- bound to all lsp
M.bind_lsp = function(_, bufnr)
    local key_opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, key_opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, key_opts)
    vim.keymap.set("n", "ge", vim.diagnostic.goto_next, key_opts)
    vim.keymap.set("n", "gE", vim.diagnostic.goto_prev, key_opts)
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, key_opts)
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, key_opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, key_opts)
end


M.bind_format = function(client)
    if client.server_capabilities.documentFormattingProvider then
        nmap("gf", "<cmd>lua vim.lsp.buf.format { async = true }<CR>")
    else
        nmap("gf", ":Format<cr>")
    end
end


return M
