# Given a list of words (without duplicates), please write a program that returns all concatenated words in the given list of words.
#
# A concatenated word is defined as a string that is comprised entirely of at least two shorter words in the given array.
#
# Example:
# Input: ["cat","cats","catsdogcats","dog","dogcatsdog","hippopotamuses","rat","ratcatdogcat"]
#
# Output: ["catsdogcats","dogcatsdog","ratcatdogcat"]
#
# Explanation: "catsdogcats" can be concatenated by "cats", "dog" and "cats";
#  "dogcatsdog" can be concatenated by "dog", "cats" and "dog";
# "ratcatdogcat" can be concatenated by "rat", "cat", "dog" and "cat".
# Note:
# The number of elements of the given array will not exceed 10,000
# The length sum of elements in the given array will not exceed 600,000.
# All the input string will only include lower case letters.
# The returned elements order does not matter.
#
def find_all_concatenated_words_in_a_dict(words)
  res = []
  words.each do |original_word|
    smaller_words = words.select { |word| word.length < original_word.length }
    next if smaller_words.count < 2
    permutations = create_permutations(smaller_words).map { |perm| perm.join }
    p permutations
    res << original_word if permutations.include?(original_word)
  end
  res
end

def create_permutations(arr, cache = {})
  return [] if arr.length < 2
  if arr.length == 2
    cache[2] = [[arr[0], arr[1]], [arr[1], arr[0]]]
    return [[arr[0], arr[1]], [arr[1], arr[0]]]
  end
  prev_perms = create_permutations(arr[1..-1], cache)
  next_perms = []
  prev_perms.each do |perm|
    (0..perm.length).each do |idx|
      next_perms << perm[0...idx] + [arr[0]] + perm[idx..-1]
    end
  end
  final_perms = [next_perms]
  (2..arr.length-1).each do |stack|
    final_perms += cache[stack]
  end
  cache[arr.length] = final_perms
  final_perms
end
