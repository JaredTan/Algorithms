# def min_patches(nums, n)
#   hash = {}
#   (1..n).each do |i|
#     hash[i] = false
#   end
#   sums = create_sums(nums, n)
#   sums.each do |sum|
#     hash[sum] = true
#   end
#   count = 0
#   while count_true_hash(hash, n) < n
#     lowest = lowest_hash_val(hash)
#     nums.push(lowest)
#     sums = create_sums(nums, n)
#     sums.each do |sum|
#       hash[sum] = true
#     end
#     count += 1
#   end
#   count
# end
#
# def create_sums(arr, n)
#   return [] if arr.length == 0
#   cache = { 1 => [arr[0]]}
#   (2..arr.length).each do |length|
#     prev_sums = cache[length - 1]
#     new_sums = [arr[length - 1]]
#     prev_sums.each do |prev_sum|
#       new_sum = prev_sum + arr[length - 1]
#       new_sums << new_sum unless new_sums.include?(new_sum) || prev_sums.include?(new_sum) || new_sum > n
#     end
#     cache[length] = new_sums + prev_sums
#   end
#   cache[arr.length]
# end
#
# def count_true_hash(hash, n)
#   i = 1
#   count = 0
#   while i <= n
#     count += 1 if hash[i]
#     i += 1
#   end
#   count
# end
#
# def lowest_hash_val(hash)
#   low = 1
#   while hash[low]
#     low += 1
#   end
#   low
# end

def min_patches(nums, n)
  i = 0
  range_after = 1
  count = 0
  while range_after <= n
    if i >= nums.length || nums[i] > range_after
      count += 1
      range_after += range_after
    else
      range_after += nums[i]
      i += 1
    end
  end
  count
end
