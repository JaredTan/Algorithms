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
