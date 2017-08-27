require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @store = StaticArray.new(8)
    @capacity = 8
  end

  # O(1)
  def [](index)
   raise('index out of bounds') if index >= length
   @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise('index out of bounds') if @length <= 0
    el = @store[@length - 1]
    @length -= 1
    @store[length] = nil
    el
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length >= capacity
    @store[length] = val
    @length += 1
    @store
  end

  # O(n): has to shift over all the elements.
  def shift
    raise('index out of bounds') if @length <= 0
    el = @store[0]
    (1..@length - 1).each do |i|
      @store[i - 1] = @store[i]
    end
    @length -= 1
    el
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! if @length > capacity
    (0..@length-1).each do |i|
      @store[@length - i] = @store[@length - i - 1]
    end
    @store[0] = val
    @length += 1
    @store
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    new_capacity = @capacity * 2
    new_store = StaticArray.new(new_capacity)

    @length.times do |i|
      new_store[i] = @store[i]
    end

    @store = new_store
    @capacity = new_capacity
    @start_idx = 0
  end
end
