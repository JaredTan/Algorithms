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
    return nil if !@root
    current_node = @root
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
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
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
