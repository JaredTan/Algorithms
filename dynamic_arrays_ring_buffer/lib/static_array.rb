# # This class just dumbs down a regular Array to be statically sized.
# class StaticArray
#   def initialize(length)
#     @length = length
#     @store = Array.new(@length)
#   end
#
#   # O(1)
#   def [](index)
#     @store[index]
#   end
#
#   # O(1)
#   def []=(index, value)
#     @store[index] = value
#   end
#
#   protected
#   attr_accessor :store
# end


# This class just dumbs down a regular Array to be statically sized.
class StaticArray
  def initialize(length)
    @store = Array.new(length)
    @length = length
  end

  # O(1)
  def [](index)
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise 'no more room' if index >= @length
    @store[index] = value
  end

  protected
  attr_accessor :store
end
