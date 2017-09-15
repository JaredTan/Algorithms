def two_sum(nums, target)
  hash_table = {}
  (0..(nums.length - 1)).each do |idx|
    hash_table[nums[idx]] = idx
  end
  (0..(nums.length - 1)).each do |idx|
    complement = target - nums[idx]
    return [idx, hash_table[complement]] if hash_table[complement] && hash_table[complement] != idx
  end
end
#
# def three_sum(nums)
#   res = []
#   hash_table = {}
#   (0...nums.length-2).each do |idx1|
#     ((idx1 + 1)...nums.length-1).each do |idx2|
#       ((idx2 + 1)...nums.length).each do |idx3|
#         if (nums[idx1] + nums[idx2] + nums[idx3] == 0) && !hash_table[[nums[idx1], nums[idx2], nums[idx3]].sort]
#           res << [nums[idx1], nums[idx2], nums[idx3]].sort
#           hash_table[[nums[idx1], nums[idx2], nums[idx3]].sort] = true
#         end
#       end
#     end
#   end
#   return res
# end

def three_sum(nums)
  hash_table = {}
  uniq_hash_table = {}
  nums.each do |num|
    hash_table[num] = true
  end
  res = []
  negatives = nums.select { |num| num < 0 }
  positives = nums.select { |num| num > 0 }
  num_zeros = nums.length - negatives.length - positives.length
  if num_zeros >= 3
    res << [0, 0, 0]
  end
  (0...negatives.length - 1).each do |idx1|
    ((idx1 + 1)...negatives.length).each do |idx2|
      complement = -1*(negatives[idx1] + negatives[idx2])
      if hash_table[complement] && !uniq_hash_table[[negatives[idx1], negatives[idx2], complement].sort]
        res << [negatives[idx1], negatives[idx2], complement]
        uniq_hash_table[[negatives[idx1], negatives[idx2], complement].sort] = true
      end
    end
  end
  (0...positives.length - 1).each do |idx1|
    ((idx1 + 1)...positives.length).each do |idx2|
      complement = -1*(positives[idx1] + positives[idx2])
      if hash_table[complement] && !uniq_hash_table[[positives[idx1], positives[idx2], complement].sort]
        res << [positives[idx1], positives[idx2], complement]
        uniq_hash_table[[positives[idx1], positives[idx2], complement].sort] = true
      end
    end
  end
  if num_zeros > 0
    negatives.each do |negative|
      complement = -1 * negative
      if hash_table[complement] && !uniq_hash_table[[negative, complement, 0].sort]
        res << [negative, complement, 0]
        uniq_hash_table[[negative, complement, 0].sort] = true
      end
    end
  end
  res
end

def can_jump(nums)
    hops_needed(nums) == 0
end

def hops_needed(nums)
    return 0 if nums.length < 2
    prev_hops_needed = hops_needed(nums[1..-1])
    if 1 - nums[0] + prev_hops_needed <= 0
        return 0
    else
        return 1 + prev_hops_needed
    end
end
