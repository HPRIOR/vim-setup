-- used to move tabs over when opening tree
local tree = {}

local isOpen = true

tree.toggle = function ()
    if isOpen then
        require'bufferline.state'.set_offset(30, 'FileTree')
        isOpen = not isOpen
    else
        require'bufferline.state'.set_offset(0)
        isOpen = not isOpen
    end
    require'nvim-tree'.toggle()
end

return tree

