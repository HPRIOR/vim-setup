local keymap = require("keymap")

return {
    {
        "HPRIOR/telescope-gpt",
        dependencies = {
            "nvim-telescope/telescope.nvim"
        }
    },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        lazy = false,
        dependencies = {
            "nvim-telescope/telescope-frecency.nvim",
            "nvim-lua/plenary.nvim" },
        version = false, -- telescope did only one release, so use HEAD for now
        keys = keymap.bind_telescope(),
        opts = {
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
            },
            pickers = {
                command_history = {
                    theme = "dropdown",
                },
                builtin = {
                    theme = "dropdown",
                },
                lsp_definitions = {
                    theme = "ivy",
                },
                lsp_references = {
                    theme = "ivy",
                },
                diagnostics = {
                    theme = "ivy",
                },
            },
            extensions = {
                gpt = {
                    title = "Gpt Actions",
                    theme = require("telescope.themes").get_dropdown {}
                }
            }
        },
        config = function(_, opts)
            require("telescope").setup(opts)
            require("telescope").load_extension('frecency')
            require('telescope').load_extension('gpt')
        end,
    },
}
