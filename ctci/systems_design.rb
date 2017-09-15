class Node

  #Person

  attr_accessor :name, :friends

  def initialize(name)
    @name
    @friends = []
  end

  def add_friend(friend)
    @friends << friend
  end

end

class TreeNode

  attr_accessor :node, :prev, :bidirectional

  def initialize(node)
    @user = node
    @prev = nil
    @bidirectional = nil
  end

end


class Edge

  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
  end


end


class SocialNetwork

  attr_accessor :nodes, :edges

  def initialize
    @nodes = []
    @edges = []
  end

  def create_friends(p1, p2)
    new_edge = Edge.new(p1, p2)
    p1.add_friend(p2)
    p2.add_friend(p1)
  end

  def add_user(user)
    @nodes << Node.new(user)
  end

  def find_shortest_path(user1, user2)
    queue1 = [user1]
    queue2 = [user2]
    visited_nodes1 = []
    visited_nodes2 = []
    collided = false
    while (queue1.length > 0 && queue.length2 > 0) || collided
      current1 = queue1.shift
      current1.friends.each do |friend|
        queue1 << friend
        tree_node1 = TreeNode.new(friend)
        visited_nodes1 << tree_node1
        friend.prev = current1
        if visited_nodes2.include?(tree_node1)
          collide_node = tree_node1
          tree_node1.bidirectional = current1
          collided = true
          break
        end
      end
      current2 = queue2.shift
      current2.friends.each do |friend|
        queue2 << friend
        tree_node = TreeNode.new(friend)
        visited_nodes2 << tree_node2
        friend.prev = current2
        if visited_nodes1.include?(tree_node2)
          collide_node = tree_node2
          tree_node2.bidirectional = current2
          collided = true
          break
        end
      end
    end

    path = [collide_node.user]
    while collide_node.prev
      current = collide_node.prev
      path.unshift(current)
    end
    other = collide_node.bidirectional
    while other.prev
      other = other.prev
      path.push(other)
    end
    path
  end
  
end
