require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !include?(key)
      @store[key.hash % num_buckets] << key
      @count += 1
      resize! if @count >= num_buckets
    end
  end

  def include?(key)
    @store[key.hash % num_buckets].each do |el|
      return true if key.hash == el.hash
    end
    return false
  end

  def remove(key)
    if include?(key)
      @store[key.hash % num_buckets].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    prev_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }
    prev_store.each do |bucket|
      bucket.each do |el|
        @store.insert(el)
      end
    end
  end
end
