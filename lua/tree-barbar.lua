local tree ={}
tree.open = function ()
   require'bufferline.state'.set_offset(30, 'FileTree')
   require'nvim-tree'.find_file(true)
end

tree.close = function ()
   require'bufferline.state'.set_offset(0)
   -- require'nvim-tree'.close()
end
return tree


