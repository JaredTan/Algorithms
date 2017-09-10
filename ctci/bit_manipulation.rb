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
