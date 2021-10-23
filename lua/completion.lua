  -- Setup nvim-cmp.
  local cmp = require'cmp'
  local luasnip = require'luasnip'

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
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

 -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- each server requires to it's capabilites to be setup here
  require('lspconfig')['tsserver'].setup {
    capabilities = capabilities
  }

  require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
  }

  require('lspconfig')['vimls'].setup {
    capabilities = capabilities
  }

  require('lspconfig')['omnisharp'].setup {
    capabilities = capabilities
  }

  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }

  require('lspconfig')['fsautocomplete'].setup {
    capabilities = capabilities
  }
