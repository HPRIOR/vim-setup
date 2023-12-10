local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')
local themes = require('telescope.themes')


local custom_commands = {
    "grammar_correction",
    "translate",
    "docstring",
    "add_tests",
    "optimize_code",
    "summarize",
    "fix_bugs",
    "explain_code",
    "interactive",
    "chat"
}

function Chat_gpt_run()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local mode = vim.fn.mode()

    local in_visual_mode = mode == 'v' or mode == 'V' or mode == "\22"

    if in_visual_mode then
        start_pos = vim.fn.getpos("v")
        end_pos = vim.fn.getpos(".")

        vim.fn.setpos("'<", start_pos)
        vim.fn.setpos("'>", end_pos)
    end

    pickers.new(themes.get_dropdown({}), {
        prompt_title = "ChatGptActions",
        finder = finders.new_table({
            results = custom_commands,
        }),
        sorter = sorters.get_generic_fuzzy_sorter(),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                local selection = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                if selection[1] == "interactive" then
                    if in_visual_mode then
                        vim.cmd("'<,'>ChatGPTEditWithInstructions")
                    else
                        vim.cmd("ChatGPTEditWithInstructions")
                    end
                elseif selection[1] == "chat" then
                    vim.cmd("ChatGPT")
                else
                    if in_visual_mode then
                        vim.cmd("'<,'>ChatGPTRun " .. selection[1])
                    else
                        vim.cmd("ChatGPTRun " .. selection[1])
                    end
                end
            end)
            return true
        end,
    }):find()
end

return {}
