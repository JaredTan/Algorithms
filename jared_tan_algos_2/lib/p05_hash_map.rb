require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % num_buckets].get(key)
  end

  def set(key, val)
    if include?(key)
      delete(key)
    end
    resize! if @count >= num_buckets
    @count += 1
    @store[key.hash % num_buckets].append(key, val)
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    old = @store[key.hash % num_buckets].remove(key)
    @count -= 1
    old
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield [node.key, node.val]
      end
    end
  end

  include Enumerable

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    prev_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) {LinkedList.new}

    prev_store.each do |bucket|
      bucket.each do |node|
        set(node.key, node.val)
      end
    end

  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
