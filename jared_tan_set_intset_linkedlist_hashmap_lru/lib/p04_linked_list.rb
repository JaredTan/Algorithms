class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    if empty?
      return nil
    else
      return @head.next
    end
  end

  def last
    if empty?
      return nil
    else
      return @tail.prev
    end
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each do |node|
      if node.key == key
        return node.val
      end
    end
    nil
  end

  def include?(key)
    any? do |node|
      node.key == key
    end
  end

  def append(key, val)
    each do |node|
      return node.val = val if node.key == key
    end

    new_node = Node.new(key, val)
    @tail.prev.next = new_node
    new_node.prev = @tail.prev
    new_node.next = @tail
    @tail.prev = new_node
    new_node
  end

  def update(key, val)
    each do |node|
      if node.key == key
        node.val = val
        break
      end
    end
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.prev.next = node.next
        node.next.prev = node.prev
        node.next = nil
        node.prev = nil
        return node.val
      end
    end
  end

  def each
    node = @head.next
    until node == @tail
      yield node
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
