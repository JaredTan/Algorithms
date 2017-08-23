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
    raise 'index out of bounds' if index >= @length
    @store[(@start_idx + index) % @capacity]
  end

  # O(1)
  def []=(index, val)
    raise 'index out of bounds' if index >= @length || index < 0
    @store[(@start_idx + index) % @capacity] = val
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
