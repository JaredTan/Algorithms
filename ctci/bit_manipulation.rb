def insertion(n, m, i, j)
  (i..j).each do |bit|
    n = n & ~(1 << bit)
  end
  n | (m << i)
end

def insertion(n, m, i, j)
  left_mask = n & (-1 << j + 1)
  right_mask = n & (1 << i) - 1
  (left_mask | right_mask) | (m << i)
end

def binary_to_string(num)
  str = ''
  base = 1/2
  while str.length < 36 || num == 0
    if num >= base
      num -= base
      str << 1
    else
      str << 0
    end
    base /= 2
  end
  if str.length > 36
    print 'ERROR'
  else
    print str
  end
end

def flip_bit_to_win(num)
  bit = convert_to_bit(num)
  zero_arr = []
  i = 0
  while i < arr.length
    zero_arr << i if bit[i] == 0
    i += 1
  end
  if zero_arr.empty?
    return arr.length
  end
  max = 0
  zero_arr.each do |zero_idx|
    (0...arr.length).each do |start|
      break if arr.length - start >= max
      temp_count = 0
      (start...arr.length).each do |idx|
        temp_count += 1 if bit[idx] == 1 || idx == zero_idx
        break if bit[idx] == 0
      end
      max = temp_count if temp_count > max
    end
  end
  max
end

def flip_bit_to_win(num)
  bit = convert_to_bit(num)
  sections = create_bit_sections(bit)
  max = 0
  sections.each_with_index do |section, idx|
    max = section.length if section.length > max
    if sections[idx + 1] && sections[idx + 1].first - section.last == 1
      merged_count = sections[idx+1].length + section.length
      max = merged_count if merged_count > max
    end
  end
  max
end

def create_bit_sections(bit)
  i = 0
  sections = []
  while i < bit.length
    if bit[i] == 1
      new_section = []
      while bit[i] == 1
        new_section << bit[i]
        i += 1
      end
      sections << new_section
    else
      i += 1
    end
  end
  sections
end

def convert_to_bit(num)
  #assume positive
  start = 1
  while start >= num
    start *= 2
  end
  bit_arr = []
  while num != 0
    if num >= start / 2
      bit_arr << 1
      num -= start/2
    else
      bit_arr << 0
    end
    start /= 2
  end
  bit_arr
end

def find_next(num)
  # obtain j and c

  bit_arr = [0] + convert_to_bit(num)
  c = 0
  bit_arr.reverse.each_with_index do |bit, idx|
    if bit == 0
      if bit_arr[idx - 1] && bit_arr[idx - 1] == 1
        j = idx
        break
      end
    else
      c += 1
    end
  end

  #turn j into 1

  num |= (1 << j)

  # turn everything to the right of j into 0

  mask = ~((1 << j) - 1)
  num &= mask

  #replace c - 1 zeros to ones, starting from the start

  mask = (1 << c - 1) - 1
  num |= mask

  num
end

def find_prev(num)
  # obtain j and c

  bit_arr = convert_to_bit(num)
  c = 0
  bit_arr.reverse.each_with_index do |bit, idx|
    if bit == 0
      if bit[idx + 1] && bit[idx + 1] == 1
        j = idx
        break
      end
    else
      c += 1
    end
  end

  #turn j + 1 into a 0

  mask = ~(( 1 << j + 1))
  nun &= mask

  #turn everything to the right of j into 0

  mask = ~((1 << j + 1) - 1)
  num &= mask

  # make the first c bits 1

  mask = (1 << c) - 1
  num |= mask

  num
end

def conversion(a, b)
  c = a ^ b
  count = 0
  while c != 0
    count += 1 if c & 1
    c >>>= 1
    #logical shifts dont work in ruby :(
  end
  count
  # 2O(b) = O(b) time where b = num of bits
end

def conversion(a, b)
  c = a ^ b
  count = 0
  while c != 0
    c = c & (c - 1)
    count += 1
  end
  count
  # runs in O(b) + O(b)/2 = O(b) - slightly faster because you dont need to check all the least significant bits.
end


def pairwise_swap(int)
  ((int & 0xAAAAAAA) >>> 1) | ((int & 0x5555555) << 1)
end


def draw_line(arr, w, x1, x2, y)
  h = arr.length * 8 / w
  y_start = (h - y) * (w / 8)
  start_offset = x1 % 8
  start = y_start + (x1 / 8)
  finish_offset = x2 % 8
  finish = y_start + (x2 / 8)
  if start == finish
    mask = (1 << (8 - start_offset + 1) - 1) & (0xFF << (8 - finish_off))
    arr[start] |= mask
  else
    changed_start = start_offset == 0 ? start + 1 : start
    changed_finish = finish_offset == 7 ? finish - 1 : finish
    arr[changed_start..changed_finish].each do |bit|
      bit |= 0xFF
    end
    #saves time by simply ORing full bits! ^
    start_mask = (1 << (8 - start_offset + 1) - 1)
    finish_mask = (0xFF << (8 - finish_offset))
    arr[changed_start] |= start_mask if start_offset != 0
    arr[changed_finish] |= finish_mask if finish_offset != 7
  end
  arr
end
