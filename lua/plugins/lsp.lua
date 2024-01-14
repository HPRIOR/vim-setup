local keymap = require("keymap")
local cmp = require("cmp")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")


return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "mason.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        opts = {
            hover = {
                border = "rounded"
            },
            signature_help = {
                border = "rounded"
            },
            diagnostics = {
                virtual_text = false,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            },
            inlay_hints = {
                enabled = false,
            },
            capabilities = {},
            autoformat = true,
            servers = {
                -- servers defined here will be passed to the setup handlers config function below
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                                path = vim.split(package.path, ";"),
                            },
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                                },
                            },
                        },
                    },
                },
            },
            setup = {},
        },
        config = function(_, opts)
            local lspconfig = require("lspconfig")
            local mason_lsp_config = require("mason-lspconfig")
            -- for winbar lsp help
            local navic = require("nvim-navic")

            local handlers = {
                ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, opts.hover),
                ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, opts.signature_help),
                ["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,
                    opts.diagnostics)
            }

            local lsp_capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )

            local on_attach_all = function(client, bufnr)
                if client.server_capabilities.documentSymbolProvider then
                    navic.attach(client, bufnr)
                end
                -- autopairs  for method calls added here so it can be customised for different lsps
                cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
                keymap.bind_lsp(client, bufnr)
                keymap.bind_format(client)
            end

            lspconfig.ocamllsp.setup {
                on_attach = on_attach_all,
                capabilities = lsp_capabilities,
                settings = {},
                handlers = handlers,
            }

            lspconfig.wgsl_analyzer.setup {
                on_attach = on_attach_all,
                capabilities = lsp_capabilities,
                settings = {},
                handlers = handlers,
            }


            mason_lsp_config.setup_handlers({
                function(server_name)
                    if (server_name == "rust_analyzer") then
                        require('rust-tools').setup({ server = { on_attach = on_attach_all } })
                    end

                    lspconfig[server_name].setup({
                        on_attach = on_attach_all,
                        capabilities = lsp_capabilities,
                        settings = opts.servers[server_name] and opts.servers[server_name].settings or {},
                        handlers = handlers,
                    })
                end,
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {
            ensure_installed = {
                -- lua
                "lua-language-server",
                "stylua",
                -- python
                "pyright",
                "black",
                -- elm
                "elm-language-server",
                -- bash
                "beautysh",
                "bash-language-server",
                -- clojure
                "clojure-lsp",
                -- json
                "json-lsp",
                -- ocaml
                -- I think these need to be managed by opam or you get odd behaviour
                -- "ocaml-lsp",
                -- "ocamlformat",
                -- rust
                "rust-analyzer",
                -- C
                "clangd",
                -- docker
                "docker-compose-language-service",
                "dockerfile-language-server",
                -- csharp/fsharp
                "omnisharp",
                "fsautocomplete",
                "fantomas",
                "html-lsp",
                "css-lsp",
                "typescript-language-server",
                "tailwindcss-language-server"

            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
            local mr = require("mason-registry")
            local function ensure_installed()
                for _, tool in ipairs(opts.ensure_installed) do
                    local p = mr.get_package(tool)
                    if not p:is_installed() then
                        p:install()
                    end
                end
            end
            if mr.refresh then
                mr.refresh(ensure_installed)
            else
                ensure_installed()
            end
        end,
    },
    -- formatting
    {
        "mhartington/formatter.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = { "williamboman/mason.nvim" },
        opts = function()
            return {
                filetype = {
                    lua = { require("formatter.filetypes.lua").stylua },
                    python = { require("formatter.filetypes.python").black },
                },
            }
        end,
    },
    {
        "adelarsq/neofsharp.vim",
        -- only load on fsharp file types
        ft = { "fs", "fsx" }
    }
}
