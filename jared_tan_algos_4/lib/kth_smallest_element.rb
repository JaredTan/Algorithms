class Array


  def kth_smallest_integer(k)
    left = 0
    right = self.length - 1
    while true
      return self[left] if left == right
      pivot_index = partition(self, left, right-left +1)
      if k - 1 == pivot_index
        return self[k-1]
      elsif k-1 < pivot_index
        right = pivot_index - 1
      else
        left = pivot_index + 1
      end
    end
  end

  def partition(array, start = 0, length = array.length, &prc)

    prc ||= Proc.new { |a, b| a <=> b }

    pivot_index = start
    pivot = array[start]
    ((start + 1)...(start + length)).each do |idx|
      if prc.call(pivot, array[idx]) > 0
        array[pivot_index + 1], array[idx] = array[idx], array[pivot_index + 1]
        pivot_index += 1
      end
    end

    array[start], array[pivot_index] = array[pivot_index], array[start]

    pivot_index




  end


end

[1,5,4,2,6,8,4,4,3,8].kth_smallest_integer(3)
