local keymap = require("keymap")


return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
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
        extensions = {}
    },
}
