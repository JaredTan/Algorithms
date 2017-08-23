require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new
  array.each do |el|
    heap.push(el)
    heap.extract if heap.count > k
    end
  heap.store
  # (2..array.length - 1).each do |i|
  #   BinaryMinHeap.heapify_up(array, i - 1, i)
  # end
  #
  # (2..array.length - 1).each do |i|
  #   array[array.length - i], array[0] = array[0], array[array.length - i]
  #   BinaryMinHeap.heapify_down(array, 0, array.length - i)
  # end
  # array.take(k)
end
