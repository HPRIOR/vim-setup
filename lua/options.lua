local M = {}

local function winbar()
    local navic = "%{%v:lua.require'nvim-navic'.get_location()%}"
    return "%{v:lua.string.gsub(expand('%'), '/', ' > ')} " .. navic
end

local opt = vim.opt
M.set_options = function()
    opt.encoding = "UTF-8"
    opt.autowrite = true           -- Enable auto write
    opt.background = "dark"
    opt.clipboard = "unnamedplus"  -- Sync with system clipboard
    opt.completeopt = "menu,menuone,noselect"
    opt.conceallevel = 3           -- Hide * markup for bold and italic
    opt.confirm = true             -- Confirm to save changes before exiting modified buffer
    opt.cursorline = true          -- Enable highlighting of the current line
    opt.expandtab = true           -- Use spaces instead of tabs
    opt.formatoptions = "jcroqlnt" -- tcqj
    opt.grepformat = "%f:%l:%c:%m"
    opt.grepprg = "rg --vimgrep"
    opt.ignorecase = true      -- Ignore case
    opt.inccommand = "nosplit" -- preview incremental substitute
    opt.laststatus = 3         -- global status line
    opt.list = false           -- Show some invisible characters (tabs...
    opt.mouse = "a"            -- Enable mouse mode
    opt.number = true          -- Print line number
    opt.pumblend = 10          -- Popup blend
    opt.pumheight = 10         -- Maximum number of entries in a popup
    opt.relativenumber = true  -- Relative line numbers
    opt.scrolloff = 4          -- Lines of context
    opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
    opt.shiftround = true      -- Round indent
    opt.shiftwidth = 4         -- Size of an indent
    opt.shortmess:append({ W = true, I = true, c = true })
    opt.showmode = false       -- Dont show mode since we have a statusline
    opt.sidescrolloff = 8      -- Columns of context
    opt.signcolumn = "yes"     -- Always show the signcolumn, otherwise it would shift the text each time
    opt.smartcase = true       -- Don't ignore case with capitals
    opt.smartindent = true     -- Insert indents automatically
    opt.spelllang = { "en" }
    opt.splitbelow = true      -- Put new windows below current
    opt.splitright = true      -- Put new windows right of current
    opt.tabstop = 4            -- Number of spaces tabs count for
    opt.termguicolors = true   -- True color support
    opt.timeoutlen = 300
    opt.undofile = true
    opt.undolevels = 10000
    opt.updatetime = 200               -- Save swap file and trigger CursorHold
    opt.wildmode = "longest:full,full" -- Command-line completion mode
    opt.winminwidth = 5                -- Minimum window width
    opt.wrap = false                   -- Disable line wrap
    opt.winbar = winbar()

    if vim.fn.has("nvim-0.9.0") == 1 then
        opt.splitkeep = "screen"
        opt.shortmess:append({ C = true })
        vim.o.ch = 0
    end

    -- Fix markdown indentation settings
    vim.g.markdown_recommended_style = 0
    vim.diagnostic.config({
        float = { border = "rounded" },
    })
    vim.notify = require("notify")

    -- setup wgsl files in lsp
    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
        pattern = "*.wgsl",
        callback = function()
            vim.bo.filetype = "wgsl"
        end,
    })
end

return M
