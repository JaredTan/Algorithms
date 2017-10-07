# @param {Integer[]} nums
# @return {Integer}
def find_number_of_lis(nums)
    cache = {}
    max = 0
    nums.each do |num|
      cache[num] = [] if !cache[num]
        cache.values.each do |val_arr|
            val_arr.each do |vals|
                if vals[-1] < num
                  cache[num] << vals + [num]
                end
            end
        end
        cache[num] << [num]
        max_length = cache[num].sort_by{ |arr| arr.length}[-1].length
        max = max_length if max_length > max
    end
    count = 0
    cache.values.each do |val_arr|
        val_arr.each do |vals|
         count += 1 if vals.length == max
        end
    end
    count
end
