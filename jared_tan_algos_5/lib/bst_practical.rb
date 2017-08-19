require_relative 'binary_search_tree'

def kth_largest(tree_node, k)
  if BinarySearchTree.size(tree_node.right) == k - 1
    return tree_node
  elsif BinarySearchTree.size(tree_node.right) >= k
    return kth_largest(tree_node.right, k)
  else
    return kth_largest(tree_node.left, k - BinarySearchTree.size(tree_node.right) - 1)
  end
end

# O Log (n) time and space!

# Also.. a little slower but easier. O(N) time and O(N) space :o
#
# def kth_largest(tree_node, k)
#   arr = reverse_order_traversal(tree_node)
#   arr[k - 1]
#
# end
#
# def reverse_order_traversal(tree_node = @root, arr = [])
#   reverse_order_traversal(tree_node.right, arr) if tree_node.right
#   arr << tree_node
#   reverse_order_traversal(tree_node.left, arr) if tree_node.left
#   arr
# end
