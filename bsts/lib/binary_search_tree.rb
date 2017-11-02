# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

require_relative 'bst_node'

class BinarySearchTree
  attr_reader :root
  def initialize
    @root = nil
  end

  def insert(value)
    return @root = BSTNode.new(value) if !@root
    current_node = @root
    while true
      if value <= current_node.value
        if !current_node.left
          return current_node.left = BSTNode.new(value)
        else
          current_node = current_node.left
        end
      else
        if !current_node.right
          return current_node.right = BSTNode.new(value)
        else
          current_node = current_node.right
        end
      end
    end
  end

  def find(value, tree_node = @root)
    current = @root
    while current
      return current if current.value == value
      if value > current.value
        current = current.right
      else
        current = current.left
      end
    end
    return nil
  end

  def find_parent(value)
    current = @root
    return nil if current.value == value
    while current
      return nil if !current.right && !current.left
      return current if current.left.value == value || current.right.value == value
      if current.value > value
        current = current.left
      else
        current = current.right
      end
    end
  end


  def delete(value)
    delete_node = find(value)
    return if !delete_node
    delete_left = delete_node.left
    delete_right = delete_node.right
    delete_parent = find_parent(value)
    if !delete_left && !delete_right
      if delete_parent
        if delete_parent.value > value
          delete_parent.left = nil
        else
          delete_parent.right = nil
        end
      else
        @root = nil
      end
    elsif (delete_right && !delete_left) || (delete_left && !delete_right)
      if delete_parent
        if delete_left
          delete_parent.left = delete_left
        else
          delete_parent.right = delete_right
        end
      else
        if delete_left
          @root = delete_left
        else
          @root = delete_right
        end
      end
    else
      max_node = maximum(delete_node.left)
      max_node_left = max_node.left
      max_node_parent = find_parent(max_node.value)
      if delete_parent
        if delete_parent.value > max_node.value
          delete_parent.left = max_node
        else
          delete_parent.right = max_node
        end
      else
        @root = max_node
      end
      max_node_parent.right = max_node_left
      max_node.left = delete_left
      max_node.right = delete_right
    end

  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    current = tree_node
    return nil if !current
    while current.right
      current = current.right
    end
    current
  end



  def depth(tree_node = @root)
    return 0 if !tree_node || (!tree_node.left && !tree_node.right)
    1 + [depth(tree_node.left), depth(tree_node.right)].max
  end

  def is_balanced?(tree_node = @root)
    return true if !tree_node || (!tree_node.left && !tree_node.right)
    return false if (depth(tree_node.left) - depth(tree_node.right)).abs > 1
    [is_balanced?(tree_node.right), is_balanced?(tree_node.left)].all?
  end

  def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr) if tree_node.right
    arr
  end

  def self.size(tree_node = @root)
    return 0 if !tree_node
    1 + size(tree_node.left) + size(tree_node.right)
  end

end
