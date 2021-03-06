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

def parens(n)
  return [] if n == 0
  return ['()'] if n == 1
  hash_map = {}
  new_parens = []
  old_parens = parens(n - 1)
  old_parens.each do |old_paren|
    front = '()' + old_paren
    if !hash_map[front]
      new_parens << front
      hash_map[front] = true
    end
    cover = '(' + old_paren + ')'
    if !hash_map[cover]
      new_parens << cover
      hash_map[cover] = true
    end
    back = old_paren + '()'
    if !hash_map[back]
      new_parens << back
      hash_map[back] = true
    end
  end
  new_parens
end

def paint_fill_bfs(screen, start, color)
  hash_map = {}
  queue = [start]
  while queue.length > 0
    current = queue.shift
    adjacent_coords(screen, current, color).each do |coord|
      row, col = coord
      if !hash[coord]
        screen[row][col] = color
        hash[coord] = true
        queue << coord
      end
    end
  end
  screen
end

def adjacent_coords(screen, coord, color)
  res = []
  row = coord[0] - 1
  while row < coord[0] + 1
    col = coord[1] - 1
    while col < coord[1] + 1
      res << [row, col] if screen[row][col] && screen[row][col] != color
      col += 1
    end
    row += 1
  end
  res
end

def paint_fill_dfs(screen, coord, color)
  row, col = coord
  return if !screen[row][col] || screen[row][col] == color
  # return if row < 0 || row >= screen.length
  # return if col < 0 || col >= screen[0].length
  screen[row][col] = color
  paint_fill_dfs(screen, [row - 1, col], color)
  paint_fill_dfs(screen, [row + 1, col], color)
  paint_fill_dfs(screen, [row, col - 1], color)
  paint_fill_dfs(screen, [row, col + 1], color)
  return scren
end

def coins(n)
  cache = {1 => ['p']}
  return cache[n] if cache[n]
  (2..n).each do |sum|
    temp_coins = []
    (1...sum).each do |a|
      if sum == 5
        temp_coins << 'n'
      elsif sum == 10
        temp_coins << 'd'
      elsif sum == 25
        temp_coins << 'q'
      end
      cache[a].each do |a_coins|
        cache[sum - a].each do |b_coins|
          temp_coins << a_coins + b_coins
        end
      end
    end
    cache[sum] = temp_coins
  end
  cache[n]
end

def eight_queens
  cache = create_cache
  (2..8).each do |num_queens|
    next_queens = []
    cache[num_queens - 1].each do |coord|
      spots = available_spots(cache_num_queens[num_queens - 1])
      spots.each do |spot|
        next_queens << spot + coords
      end
    end
    cache[num_queens] = next_queens
  end
  cache[8]
end

def create_cache
  cache = {}
  arr = []
  (0..7).each do |i|
    (0..7).each do |j|
      arr << [i, j]
    end
  end
  cache[1] = arr
  cache
end

def available_spots(coords)
  spots = create_cache[1]
  coords.each do |coord|
    spots.delete(horizontals(coord))
    spots.delete(verticals(coord))
    spots.delete(diagonals(coord))
  end
  spots
end

def stack_of_boxes(boxes, current_box = nil)
  ok_boxes = boxes_fit?(boxes, current_box)
  return current_box.height if current_box && ok_boxes.length == 0
  heights = []

  ok_boxes.each do |box|
    heights << current_box.height + stack_of_boxes(ok_boxes, box)
  end
  heights.max
end

def boxes_fit?(boxes, current_box)
  return boxes if !current_box
  boxes.each do |box|
    next if box == current_box
    if box.height < current_box.height && box.width < current_box.width && box.depth < current_box.depth
      ok_boxes << box
    end
  end
  return ok_boxes
end

class BooleanEval
  def initialize
    @cache = {}
  end

  def boolean_eval(str, boolean)
    #basecase
    return 0 if str.length == 0
    if str.length == 1
      return 1 if str[0] == 0 && !boolean
      return 1 if str[0] == 1 && boolean
      return 0 if str[0] == 0 && boolean
      return 0 if str[0] == 1 && !boolean
    end

    count = 0
    i = 0
    while i < str.length - 1
      left = str[0..i]
      right = str[i+2..-1]
      if boolean
        if str[i+1] == '|'
          count += boolean_eval(left, true) * boolean_eval(right, true)
          count += boolean_eval(left, true) * boolean_eval(right, false)
          count += boolean_eval(left, false) * boolean_eval(right, true)
        elsif str[i+1] == '&'
          count += boolean_eval(left, true) * boolean_eval(right, true)
        else
          count += boolean_eval(left, true) * boolean_eval(right, false)
          count += boolean_eval(left, false) * boolean_eval(left, true)
        end
      else
        if str[i+1] == '|'
          count += boolean_eval(left, false) * boolean_eval(right, false)
        elsif str[i+1] == '&'
          count += boolean_eval(left, true) * boolean_eval(right, false)
          count += boolean_eval(left, false) * boolean_eval(right, false)
          count += boolean_eval(left, false) * boolean_eval(right, true)
        else
          count += boolean_eval(left, true) * boolean_eval(right, true)
          count += boolean_eval(left, false) * boolean_eval(left, false)
        end
      end
      i += 2
    end
    count
  end

end
