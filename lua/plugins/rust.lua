return {
    -- Extend auto completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "Saecki/crates.nvim",
                event = { "BufRead Cargo.toml" },
                config = true,
            },
        },
        opts = function(_, opts)
            local cmp = require("cmp")
            opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
                { name = "crates" },
            }))
        end,
    },
    {
        "simrat39/rust-tools.nvim",
        lazy = true,
        ft = { "rs" }
    },
    -- Correctly setup lspconfig for Rust 🚀
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "simrat39/rust-tools.nvim"
        },
        opts = {
            servers = {
                -- Ensure mason installs the server
                rust_analyzer = {
                    settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                                runBuildScripts = true,
                            },
                            -- Add clippy lints for Rust.
                            checkOnSave = {
                                allFeatures = true,
                                command = "clippy",
                                extraArgs = { "--no-deps" },
                            },
                            procMacro = {
                                enable = true,
                                ignored = {
                                    ["async-trait"] = { "async_trait" },
                                    ["napi-derive"] = { "napi" },
                                    ["async-recursion"] = { "async_recursion" },
                                },
                            },
                        },
                    },
                },
            },
        },
    },
}
