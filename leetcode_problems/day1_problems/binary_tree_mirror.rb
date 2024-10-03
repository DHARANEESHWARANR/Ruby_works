# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {TreeNode}

def invert_tree(root)
    return root if root==nil
    root.left,root.right = root.right,root.left
    invert_tree(root.left)   #inverting left
    invert_tree(root.right)  #inverting right
    root
end