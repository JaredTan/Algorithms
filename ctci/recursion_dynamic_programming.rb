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

def power_set(arr)
  return [] if arr.length == 0
  subs = power_set(arr[0...-1])
  subs + subs.maps { |sub| sub + arr.last }
end

def rec_multiply(m, n)
  return 0 if m == 0 || n == 0
  return m if n == 1
  return n if m == 1
  bigger = m >= n ? m : n
  smaller = m >= n ? n : m
  if smaller.odd?
    return bigger + (rec_multiply(bigger, smaller >> 1)) << 1
  else
    return (rec_multiply(bigger, smaller >> 1)) << 1
  end
  # O(log(smaller))
end

class TowersOfHanoi
  def initialize(n)
    @n = n
    @s1 = []
    @s2 = []
    @s3 = []
    (1..n).each do |disk|
      @s1.unshift(disk)
    end

    rec_towers_of_hanoi(@n, @s1, @s2, @s3)
  end

  def rec_towers_of_hanoi(n, s1, s2, s3)
    if n == 1
      return s3.unshift(s1.shift)
    else
      rec_towers_of_hanoi(n - 1, s1, s3, s2)
      s3.unshift(s1)
      rec_towers_of_hanoi(n - 1, s1, s2, s3)
    end
  end

  def perm_without_dups(str)
    return [str] if str.length <= 1
    old_perms = perm_without_dups(str[0...-1])
    new_perms = []
    old_perms.each do |perm|
      (0..perm.length).each do |idx|
        new_perms << perm[0...idx] + str[-1] + perm[idx..-1]
      end
    end
    new_perms
  end

  def perms_with_dups(str, hash_map = nil)
    return [str] if str.length <= 1
    if !hash_map
      hash_map = Hash.new(0)
      str.each_char do |char|
        hash_map[char] += 1
      end
    end
    return [] if hash_map.values.all? {|val| v == 0 }
    new_perms = []
    hash_map.keys.each do |prefix|
      if hash_map[key] > 0
        hash_map[key] -= 1
        new_perms << prefix + perms_with_dups(str, hash_map)
        hash_map[key] += 1
      end
    end
    new_perms
  end
