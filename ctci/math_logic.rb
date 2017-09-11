def queen(families)
  boys = 0
  girls = 0
  i = 0
  while i < families
    birth = rand(2)
    while birth != 0
      boys += 1
      birth = rand(2)
    end
    girls += 1
    puts "#{100 * girls.to_f / (boys + girls)}% girls"
    i += 1
  end
  puts "#{100 * girls.to_f / (boys + girls)}% girls in #{families} families"
end

def poison
  bottles = Array.new(1000, false)
  bottles[rand(1000)] = true
  num_unknown_bottles = 1000
  num_strips = 10
  strip_bottle_hash = {}
  current_partition = num_unknown_bottles - (num_unknown_bottles / num_strips)
  assign_strips(num_strips, strip_bottle_hash, current_partition)

  #run 1
  new_start, new_finish, key = run_strips(strip_bottle_hash, bottles)

  num_unknown_bottles = new_finish - new_start + 1
  bottle_offset = new_start

  if new_start > current_partition # was one of the non strips
    current_partition = (num_unknown_bottles /( num_strips + 1))
    assign_strips(num_strips, strip_bottle_hash, current_partition)
  else
    num_strips -= 1
    current_partition = (num_unknown_bottles - (num_strips + 1))
    assign_strips(num_strips, strip_bottle_hash, current_partition)
  end

  #run 2
  new_start, new_finish = run_strips(strip_bottle_hash, bottles)

  num_unknown_bottles = new_finish - new_start + 1
  bottle_offset += new_start

  if new_start > current_partition # was one of the non strips
    current_partition = (num_unknown_bottles /( num_strips + 1))
    assign_strips(num_strips, strip_bottle_hash, current_partition)
  else
    num_strips -= 1
    current_partition = (num_unknown_bottles - (num_strips + 1))
    assign_strips(num_strips, strip_bottle_hash, current_partition)
  end

  #run 3
  new_start, new_finish = run_strips(strip_bottle_hash, bottles)
  bottle_offset += new_start
  return bottle_offset + new_start
end

def assign_strips(num_strips, strip_bottle_hash, current_partition)
  original_partition = current_partition
  (1..num_strips).each do |strip|
    strip_bottle_hash[strip] = current_partition
    current_partition += original_partition
  end
end

def run_strips(strip_bottle_hash, bottles)
  current_bottle = 0
  strip_bottle_hash.keys.sort.each do |key|
    (current_bottle..strip_bottle_hash[key]).each do |test|
      return [current_bottle, strip_bottle_hash[key]] if bottles[test]
      current_bottle = partition + 1
    end
  end
  return [current_bottle, bottles.length]
end
