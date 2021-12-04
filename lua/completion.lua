 -- Setup nvim-cmp.
  local cmp = require'cmp'
  local luasnip = require("luasnip")
  local lspkind = require("lspkind")

  -- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'
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
      { name = 'buffer' },
      { name = 'luasnip' }, -- For luasnip users.
      { name = 'path' },
      { name = 'cmdline'}
    }),
    formatting = {
        format = lspkind.cmp_format({with_text = false, maxwidth = 50})
      }
  })

