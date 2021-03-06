-- Setup nvim-cmp.
local cmp = require 'cmp'
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

lspkind.init({
    mode = 'symbol_text'
})


local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- use nvim-autopairs to add brackets on method/function completion
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))


cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    mapping = {
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end,
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        --{ name = 'buffer' },
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'path' },
        { name = 'cmdline' }
    }),
    formatting = {
        format = lspkind.cmp_format({ with_text = true, maxwidth = 50 })
    },
    experimental = {
        ghost_text = false
    }
})
