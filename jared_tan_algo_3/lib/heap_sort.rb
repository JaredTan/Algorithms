require_relative "heap"

class Array
  def heap_sort!
    (2..self.count).each do |length|
      BinaryMinHeap.heapify_up(self, length - 1, length)
    end

    (2..self.count).each do |length|
      self[self.count - length + 1], self[0] = self[0], self[self.count - length + 1]
      BinaryMinHeap.heapify_down(self, 0, self.count - length + 1)
    end

    self.reverse!
  end
end
