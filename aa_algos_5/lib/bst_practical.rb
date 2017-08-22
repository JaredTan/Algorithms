def kth_largest(tree_node, k)
  kth_node = { count: 0, correct_node: nil }
  reverse_inorder(tree_node, kth_node, k)[:correct_node]
end

def reverse_inorder(tree_node, kth_node, k)
  if tree_node && kth_node[:count] < k 
    kth_node = reverse_inorder(tree_node.right, kth_node, k)
    if kth_node[:count] < k 
      kth_node[:count] += 1
      kth_node[:correct_node] = tree_node 
    end

    if kth_node[:count] < k
      kth_node = reverse_inorder(tree_node.left, kth_node, k)
    end
  end

  kth_node
end