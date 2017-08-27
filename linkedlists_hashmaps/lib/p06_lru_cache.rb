require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key]
      node = @map[key]
      update_node!(node)
      node.val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    new_val = @prc.call(key)
    new_node = @store.append(key, new_val)
    @map[key] = new_node

    eject! if count > @max
    new_val
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    node.prev.next = node.next
    node.next.prev = node.prev
    node.prev = @store.last
    node.next = @store.last.next
    @store.last.next = node
    # most recently accessed node!
  end

  def eject!
    node = @store.first
    node.prev.next = node.next
    node.next.prev = node.prev
    @map.delete(node.key)
  end
end
