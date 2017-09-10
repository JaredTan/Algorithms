def min_tree(sorted)
  res = []
  queue = [sorted]
  until queue.empty?
    curr_arr = queue.shift
    mid = curr_arr.length / 2
    res << curr_arr[mid] if curr_arr[mid]
    queue << curr_arr[0...mid] if curr_arr[0...mid].length > 0
    queue << curr_arr[mid+1...curr_arr.length] if curr_arr[mid+1...curr_arr.length].length > 0
  end
  res
end

def min_tree(sorted)
  mid = sorted.length / 2
  node = Node.new(sorted[mid])
  node.left = min_tree(sorted[0...mid]) if sorted[0...mid].length > 0
  node.right = min_tree(sorted[mid+1...sorted.length]) if sorted[mid+1...sorted.length].length > 0
  node
end

#[1,2,4,6,7,10,11] => [6,2,10,1,4,7,11]

min_tree([1,2,4,6,7,10,11])

def lists_of_depths(tree_node, lists = [], depth = 0) DFS
  if lists.length == depth
    list = LinkedList.new
    lists << list
  else
    list = lists[depth]
  end
  list.append(tree_node)
  lists_of_depths(tree_node.left, lists, depth + 1) if tree_node.left
  lists_of_depths(tree_node.right, lists, depth + 1) if tree_node.right
  lists
end

def lists_of_depths(tree_node) BFS
  tree_node.depth = 0
  lists = []
  queue = [tree_node]
  while queue.length > 0
    node = queue.shift
    if lists.length == node.depth
      list = LinkedList.new
      lists << list
    else
      list = lists[node.depth]
    end
    list.append(node)
    if node.left
      node.left.depth = node.depth + 1
      queue << node.left
    end
    if node.right
      node.right.depth = node.depth + 1
      queue << node.right
    end
  end
  lists
end

def is_balanced?(tree_node)
  return true if !tree_node
  return false if (depth(tree_node.left) - depth(tree_node.right)).abs > 1
  [is_balanced?(tree_node.left), is_balanced?(tree_node.right)].all?
end


def depth(tree_node)
  return 0 if !tree_node
  1 + [depth(tree_node.left), depth(tree_node.right)].max
end

def validateBST(tree_node, min = nil, max = nil)
  return true if !tree_node
  return false if (min && tree_node.val < min) || (max && tree_node.val > max)
  [validateBST(tree_node.left, min, tree_node.val), validateBST(tree_node.right, tree_node.val, max)].all?
end


def successor(node)
  if !node.right
    current_node = node
    while current_node.parent && current_node.parent.right == current_node
      current_node = node.parent
    end
    return nil if !current_node.parent
    return current_node
  else
    return left_most_node(node.right)
  end
end

def left_most_node(node)
  while node.left
    node = node.left
  end
  return node
end

def build_order(projects)
  return 'no projects' if projects.empty?
  edge_hash = {}
  queue = []
  result = []
  projects.each do |project|
    edge_hash[project] = project.in_edges.count
    queue << project if project.in_edges.empty?
  end
  raise 'no starting project' if queue.empty?
  while queue.length > 0
    current = queue.shift
    current.out_edges.each do |edge|
      new_project = edge.to_project
      queue << new_project if edge_hash[new_project] == 0
      edge_hash[new_project] -= 1
      raise 'loop' if edge_hash[new_project] < 0
    end
    result << current unless result.include?(current)
  end
  edge_hash.keys.each do |project|
    puts "#{project} is not included in the build order" if edge_hash[project] != 0
  end
  return result
end

def first_common_ancestor(node1, node2)
  return node1.parent if is_descendant_of(node1.parent, node2)
  return 'no common ancestor' if !node1.parent || !node2
  first_common_ancestor(node1.parent, node2)
end

def is_descendant_of(tree_node, node)
  return false if !tree_node || !node
  return true if tree_node.left == node || tree_node.right == node
  [is_descendant_of(tree_node.left, node), is_descendant_of(tree_node.right, node)].any?
end

def BSTSequences(tree_node)
  return [] if !tree_node
  return [tree_node.val] if !tree_node.left && !tree_node.right
  left_side = BSTSequences(tree_node.left)
  right_side = BSTSequences(tree_node.right)
  res = []
  if left_side.empty?
    right_side.each do |right_seq|
      res << tree_node.val.concat(right_seq)
    end
  elsif right_side.empty?
    left_side.each do |left_seq|
      res << tree_node.val.concat(left_seq)
    end
  else
    left_side.each do |left_seq|
      right_side.each do |right_seq|
        res << tree_node.val.concat(left_seq).concat(right_seq)
        res << tree_node.val.concat(right_seq).concat(left_seq)
      end
    end
  end
  res
end

def check_subtree(tree_node1, tree_node2)
  big_node = bfs(tree_node1, tree_node2)
  return false if !big_node
  recurse_subtrees?(big_node, tree_node2)
end

def bfs(tree_node1, tree_node2)
  queue = [tree_node1]
  while queue.length > 0
    current_node = queue.shift
    break if current_node == tree_node2
    queue << current_node.left if current_node.left
    queue << current_node.right if current_node.right
  end
  return nil if current_node != tree_node2
  return current_node
end

def recurse_subtrees?(tree_node1, tree_node2)
  return true if tree_node1.left.nil? && tree_node2.left.nil? && tree_node1.right.nil? && tree_node.left.nil?
  return false if tree_node1.left != tree_node2.left || tree_node1.right != tree_node2.right
  [recurse_subtrees(tree_node1.left, tree_node2.left), recurse_subtrees(tree_node1.right, tree_node2.right)].all?
end

###

def pairs_with_sum_breadth_traversal(tree_node)
  queue = []
  queue = [tree_node] if tree_node
  count = 0
  while queue.length > 0
    current = queue.shift
    count += pairs_with_sum(current)
    queue << current.left if current.left && (current.left.left || current.left.right)
    queue << current.right if current.right && (current.right.left || current.right.right)
  end
  count
end

def pairs_with_sum_in_order_traversal(tree_node, count = 0)
  pairs_with_sum_in_order_traversal(tree_node.left, count) if tree_node.left && (tree_node.left.left || tree_node.left.right)
  count += pairs_with_sum(tree_node)
  pairs_with_sum_in_order_traversal(tree_node.right, count) if tree_node.right && (tree_node.right.left || tree_node.right.right)
  count
end


def pairs_with_sum(tree_node, prev_val = 0)
  return 0 if !tree_node.left || !tree_node.right
  sum = prev_val + tree_node.val
  count = 0
  count += 1 if sum == tree_node.left.val
  count += 1 if sum == tree_node.right.val
  count + pairs_with_sum(tree_node.left, sum) + pairs_with_sum(tree_node.right, sum)
end
