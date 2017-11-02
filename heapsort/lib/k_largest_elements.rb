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

def five_hundred_files(arr_of_arrs)
  # We will need to store info about where the element came from,
  # so we need to pass a proc that will compare the first item (the value)
  # from an entry containing relevant information
  prc = Proc.new { |el1, el2| el1[0] <=> el2[0] }
  heap = BinaryMinHeap.new(&prc)
  result = []

  # Populate with first elements
  arr_of_arrs.length.times do |i|
    # Relevant info: [value, origin array number, origin index]
    heap.push([arr_of_arrs[i][0], i, 0])
  end

  # Extract the minimum element and use the meta-data to select the
  # next element to push onto the heap
  while  heap.count > 0
    min = heap.extract
    result << min[0]

    next_arr_i = min[1]
    next_idx = min[2] + 1
    next_el = arr_of_arrs[next_arr_i][next_idx]

    heap.push([next_el, next_arr_i, next_idx]) if next_el
  end
  result
end


arr_of_arrs = [[3,5,7], [0,6], [0,6,28]]

p five_hundred_files(arr_of_arrs)
