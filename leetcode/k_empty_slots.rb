# @param {Integer[]} flowers
# @param {Integer} k
# @return {Integer}
def k_empty_slots(flowers, k)
    garden = Array.new(flowers.length, nil)
    flowers.each_with_index do |flower, idx|
        garden[flower - 1] = true
        return idx + 1 if k_garden?(garden, k)
    end
    return -1
end

def k_garden?(garden, k)
    i = 0
    while i < garden.length - 1
      return false if i >= garden.length - k
      return true if garden[i] && garden[i + k + 1] && empty_inners(garden, i, i+k+1)
      i += 1
    end
    return false
end

def empty_inners(garden, start, last)
  (start+1...last).each do |idx|
    return false if garden[idx]
  end
  true
end



# @param {Integer[]} flowers
# @param {Integer} k
# @return {Integer}
def k_empty_slots(flowers, k)
    garden = Array.new(flowers.length, nil)
    counts = []
    flowers.each_with_index do |flower, idx|
        garden[flower - 1] = true
        return idx + 1 if counts.include?(k)
        counts = add_counts(counts, garden)
    end
    return -1
end

def add_counts?(counts, garden)
    
    # i = 0
    # while i < garden.length - 1
    #   return false if i >= garden.length - k
    #   return true if garden[i] && garden[i + k + 1] && empty_inners(garden, i, i+k+1)
    #   i += 1
    # end
    # return false

end

def empty_inners(garden, start, last)
  (start+1...last).each do |idx|
    return false if garden[idx]
  end
  true
end
