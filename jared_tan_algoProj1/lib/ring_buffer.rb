require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @store = StaticArray.new(8)
    @start_idx = 0
    @capacity = 8
  end

  # O(1)
  def [](index)
    unless (index >= 0) && (index < length)
      raise "index out of bounds"
    else
      return @store[(index + start_idx) % capacity]
    end
  end

  # O(1)
  def []=(index, val)
    unless (index >= 0) && (index < length)
      raise "index out of bounds"
    else
      @store[(index + start_idx) % capacity] = val
    end
  end

  # O(1)
  def pop
    raise 'index out of bounds' if @length <= 0
    el = @store[(@start_idx + @length - 1) % @capacity]
    @store[(@start_idx + @length - 1) % @capacity] = nil
    @length -= 1
    el
  end

  # O(1) ammortized
  def push(val)
    resize! if @length >= @capacity
    @store[(@start_idx + @length) % @capacity ] = val
    @length += 1

  end

  # O(1)
  def shift
    raise 'index out of bounds' if @length <= 0
    el = @store[@start_idx % @capacity]
    @store[@start_idx % @capacity] = nil
    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1
    el
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length >= @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @length += 1
    @store[@start_idx % @capacity] = val

  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    new_capacity = @capacity * 2
    new_store = StaticArray.new(new_capacity)

    @length.times do |i|
      new_store[i] = @store[(@start_idx + i) % @capacity]
    end

    @store = new_store
    @capacity = new_capacity
    @start_idx = 0
  end
end
