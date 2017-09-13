def triple_step_bottom_up(n)
  cache = {
    1 => 1,
    2 => 2,
    3 => 4
  }
  return cache[n] if cache[n]
  (4..n).each do |steps|
    cache[steps] = cache[n - 3] + cache[n - 2] + cache[n - 1]
  end
  cache[n]
end

class TripleStep

  def initialize
    @cache = {
      1 => 1,
      2 => 2,
      3 => 4
    }
  end

  def triple_step_top_down(n)
    return @cache[n] if @cache[n]
    @cache[n] = @cache[n - 3] + @cache[n - 2] + @cache[n - 1]
    @cache[n]
  end

end

def robot_in_a_grid(rows, cols)

  cache = { [0, 0] => 0 }
  current_row = 1
  current_col = 1
  while !cache[rows - 1, cols - 1]
    (0..current_col - 1).each do |new_col|
      if [current_row, new_col].blocked?
        cache[current_row, new_col] = nil
      else
        top = cache[current_row  - 1, new_col] || 0
        left = cache[current_row, new_col - 1] || 0
        cache[current_row, new_col] = top + left
      end
    end
    (0..current_row - 1).each do |new_row|
      if [new_row, current_col].blocked?
        cache[new_row, current_col] = nil
      else
        top = cache[new_row - 1, current_col] || 0
        left = cache[new_row, current_col - 1] || 0
        cache[new_row, current_col] = top + left
      end
    end
    cache[current_row, current_col] = cache[current_row - 1, current_col] + cache[current_row, current_col - 1]
    current_row += 1 unless current_row > rows - 1
    current_col += 1 unless current_col > cols - 1
  end
  cache[rows - 1, cols - 1]

end


def magic_index(arr, offset = 0)
  return false if arr.length == 0
  mid = arr.length / 2
  return arr[mid] if arr[mid] == mid + offset
  if arr[mid] < mid + offset
    magic_index(arr[(mid+1)..-1], offset + mid + 1)
  else
    magic_index(arr[0...mid], offset)
  end
end

magic_index([-3,-1,1,2,0,6,8])
