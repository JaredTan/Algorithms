# Post Order Traversal:

require_relative 'binary_search_tree'

  def post_order_traversal(tree_node, arr = [] )
    post_order_traversal(tree_node.left, arr) if tree_node.left
    post_order_traversal(tree_node.right, arr) if tree_node.right
    arr << tree_node
    arr
  end

# Pre Order Traversal:

  def pre_order_traversal(tree_node, arr = [])
    arr << tree_node
    pre_order_traversal(tree_node.left, arr) if tree_node.left
    pre_order_traversal(tree_node.right, arr) if tree_node.right
    arr
  end


# LCA:
# In a binary search tree, an *ancestor* of a `example_node` is a node
# that is on a higher level than `example_node`, and can be traced directly
# back to `example_node` without going up any levels. (I.e., this is
# intuitively what you think an ancestor should be.) Every node in a binary
# tree shares at least one ancestor -- the root. In this exercise, write a
# function that takes in a BST and two nodes, and returns the node that is the
# lowest common ancestor of the given nodes. Assume no duplicate values.

def ancestor(tree_node, node1, node2)
  node1.value < node2.value ?
  low_node = node1
  high_node = node2 :
  high_node = node1
  low_node = node2
  return nil if tree_node.nil?
  if bst.root.value.between?(low_node.value, high_node.value)
    return tree_node
  elsif
    bst.root.value < low_node.value
    ancestor(tree_node.right, node1, node2)
  else
    ancestor(tree_node.left, node1, node2)
end


end
