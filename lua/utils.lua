local M = {}


function M.table_to_string(t, delimiter)
    local result = ''
    delimiter = delimiter or ', ' -- set a default delimiter if none was provided
    local table_len = #t
    for i = 1, table_len do
        if i ~= table_len then
            result = result .. t[i] .. delimiter
        else
            result = result .. t[i]
        end
    end
    return result
end


function M.lsp_client_strs()
    local clients = vim.lsp.buf_get_clients()
    local clients_list = {}
    for _, client in pairs(clients) do
        table.insert(clients_list, client.name)
    end
    return '[' .. M.table_to_string(clients_list) .. ']'
end

return M
