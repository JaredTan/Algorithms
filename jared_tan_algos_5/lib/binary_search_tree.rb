# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

require_relative 'bst_node'

class BinarySearchTree
  attr_reader :root
  def initialize
    @root = nil
  end

  def insert(value)
    return @root = BSTNode.new(value, nil) if !@root
    current_node = @root
    while true
      if value <= current_node.value
        if !current_node.left
          return current_node.left = BSTNode.new(value, current_node)
        else
          current_node = current_node.left
        end
      else
        if !current_node.right
          return current_node.right = BSTNode.new(value, current_node)
        else
          current_node = current_node.right
        end
      end
    end
  end

  def find(value, tree_node = @root)
    return nil if !tree_node
    current_node = tree_node
    while current_node
      if value == current_node.value
        return current_node
      elsif value < current_node.value
        current_node = current_node.left
      else
        current_node = current_node.right
      end
    end
    return nil
  end

  def delete(value)
    node = find(value)
    if !node
      return nil
    end

    if !node.left && !node.right
      if node.value == @root.value
        return @root = nil
      end
      if node.value > node.parent.value
        node.parent.right = nil
        node = nil
      else
        node.parent.left = nil
        node = nil
      end
    elsif !node.left && node.right
      if node.value > node.parent.value
        node.parent.right = node.right
      else
        node.parent.left = node.right
      end
    elsif !node.right && node.left
      if node.value > node.parent.value
        node.parent.right = node.left
      else
        node.parent.left = node.left
      end
    elsif node.left && node.right
      replacement_node = maximum(node.left)
      old_left_node = node.left
      old_right_node = node.right
      if node.value == @root.value
        @root = replacement_node
        if !replacement_node.left
          replacement_node.parent.right = nil
        else
          replacement_node.parent.right = replacement_node.left
        end
        @root.parent = nil
        @root.left = old_left_node
        @root.right = old_right_node
        old_left_node.parent = @root
        old_right_node.parent = @root
      else
        if node.value > node.parent.value
          node.parent.right = replacement_node
        else
          node.parent.left = replacement_node
        end
        replacement_node.left ? replacement_node.parent.right = replacement_node.left : replacement_node.parent.right = nil
        replacement_node.parent = node.parent
        replacement_node.value == old_left_node.value ? replacement_node.left = nil : replacement_node.left = old_left_node
        replacement_node.value == old_right_node.value ? replacement_node.right = nil : replacement_node.right = old_right_node
      end
      node = nil
    end

  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    current_node = tree_node
    while current_node
      return current_node if !current_node.right
      current_node = current_node.right
    end
    return nil
  end

  def depth(tree_node = @root)
  end

  def is_balanced?(tree_node = @root)
  end

  def in_order_traversal(tree_node = @root, arr = [])
  end


  private
  # optional helper methods go here:

end
