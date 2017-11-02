# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

# require_relative 'ring_buffer'
#
# class QueueWithMax
#   attr_accessor :store
#   attr_reader :max
#
#   def initialize
#     @store = RingBuffer.new
#     @store2 = RingBuffer.new
#   end
#
#   def enqueue(val)
#     if length == 0
#       @store.push(val)
#       @store2.push(val)
#     else
#       @store.push(val)
#       p  @store2[@store2.length - 1]
#       until @store2.length == 0 || val <= @store2[@store2.length - 1]
#         @store2.pop
#       end
#       @store2.push(val)
#     end
#   end
#
#   def dequeue
#     if @store[0] == @store2[0]
#       @store.shift
#       @store2.shift
#     else
#       @store.shift
#     end
#   end
#
#   def max
#     @store2[0]
#   end
#
#   def length
#     @store.length
#   end
#
# end


require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @queue = RingBuffer.new
    @max_queue = RingBuffer.new
  end

  def enqueue(val)
    @queue.push(val)
    @max_queue.push(val)
    if length != 0
      while @max_queue[0] < val
        @max_queue.shift
      end
    end
  end

  def dequeue
    if @queue[0] == @max_queue[0]
      @queue.shift
      @max_queue.shift
    else
      @queue.shift
    end
  end

  def max
    @max_queue[0]
  end

  def length
    @queue.length
  end

end
