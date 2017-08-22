# Post Order Traversal:

require_relative 'binary_search_tree'

  def post_order_traversal(tree_node, arr = [] )
    arr << post_order_traversal(tree_node.left) if tree_node.left
    tree_node
    arr << post_order_traversal(tree_node.right) if tree_node.right
  end


# Pre Order Traversal:

def pre_order_traversal(tree_node, arr = [])
  tree_node
  arr << post_order_traversal(tree_node.left) if tree_node.left
  arr << post_order_traversal(tree_node.right) if tree_node.right
end


# LCA:
# In a binary search tree, an *ancestor* of a `example_node` is a node
# that is on a higher level than `example_node`, and can be traced directly
# back to `example_node` without going up any levels. (I.e., this is
# intuitively what you think an ancestor should be.) Every node in a binary
# tree shares at least one ancestor -- the root. In this exercise, write a
# function that takes in a BST and two nodes, and returns the node that is the
# lowest common ancestor of the given nodes. Assume no duplicate values.

def ancestor(bst, node1, node2)
  node1.value < node2.value ?
  low_node = node1
  high_node = node2 :
  high_node = node1
  low_node = node2
  return nil if bst.nil?
  if bst.root.value.between?(low_node.value, high_node.value)
    return bst.root
  elsif
    bst.root.value < low_node.value
    ancestor(bst.right, node1, node2)
  else
    ancestor(bst.left, node1, node2)
end


end
