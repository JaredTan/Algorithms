class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
    @max = max
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    return false if num > @store.length || num < 0
    @store[num]
  end

  private

  def is_valid?(num)

  end

  def validate!(num)
    raise "Out of bounds" if num < 0 || num > @max
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) {Array.new}
  end

  def insert(num)
    @store[num % num_buckets] << num
  end
  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    @store[num % num_buckets].each do |el|
      return true if num == el
    end
    return false
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num)
      @store[num % num_buckets] << num
      @count += 1
      resize! if @count > num_buckets
    end

  end

  def remove(num)
    @store[num % num_buckets].delete(num)
  end

  def include?(num)
    i = 0
    while i < @store[num % num_buckets].length
      return true if @store[num % num_buckets][i] == num
      i += 1
    end
    return false
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    prev_store = @store
    @count = 0
    @store = Array.new(num_buckets * 2) {Array.new}
    prev_store.each do |bucket|
      bucket.each do |el|
        insert(el)
      end
    end

  end

end
