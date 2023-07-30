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

-- called in lua/telescope.lua
M.bind_telescope = function()
    return {
        { "<leader>:", "<cmd>Telescope command_history<cr>",               desc = "Command history" },
        { "<leader>;", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
        { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>",     desc = "Buffer" },
        { "<leader>'", "<cmd>Telescope marks<cr>",                         desc = "Jump to Mark" },
        { "<leader>f", "<cmd>Telescope find_files<cr>",                    desc = "Find files" },
        { "<leader>g", "<cmd>Telescope live_grep<cr>",                     desc = "Live grep" },
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
        -- document symbols
        {
            "<leader>s",
            "<cmd>lua require'telescope.builtin'.lsp_workspace_symbols()<cr>",
            desc = "Workspace symbols",
        },
    }
end

-- called in lua/lsp.lua
-- bound to all lsp
M.bind_lsp = function(bufnr)
    local key_opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "K", vim.lsp.buf.hover, key_opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, key_opts)
    vim.keymap.set("n", "ge", vim.diagnostic.goto_next, key_opts)
    vim.keymap.set("n", "gE", vim.diagnostic.goto_prev, key_opts)
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, key_opts)
    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, key_opts)
    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, key_opts)
end

-- general mappings
local function window_management()
    nmap("<leader>h", "<c-w>h")
    nmap("<leader>l", "<c-w>l")
    nmap("<leader>k", "<c-w>k")
    nmap("<leader>j", "<c-w>j")
    nmap("<leader>q", ":q<CR>")
end

local function clipboard()
    vmap("<C-p>", "y'>p")
end

M.bind_format = function(client)
    if client.server_capabilities.documentFormattingProvider then
        nmap("gf", "<cmd>lua vim.lsp.buf.format { async = true }<CR>")
    else
        nmap("gf", ":Format<cr>")
    end
end

M.bind_keys = function()
    -- default mapping for formatting
    nmap("gf", ":Format<cr>")
    nmap("<leader>lg", ":LazyGit<CR>")
    window_management()
    clipboard()
end

return M
