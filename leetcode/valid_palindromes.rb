def valid_palindrome(s)
    test_left(s) || test_right(s)
end

def test_left(s)
  return true if s.length < 3
  start = 0
  last = s.length - 1
  deletions = 0
  while start < last
      left = s[start]
      right = s[last]
      if left != right
          return false if deletions > 0
          if s[start + 1] == right
              start += 1
              deletions += 1
          elsif s[last - 1] == left
              last -= 1
              deletions += 1
          else
              return false
          end
      else
          start += 1
          last -= 1
      end
  end
  return true
end

def test_right(s)
  return true if s.length < 3
  start = 0
  last = s.length - 1
  deletions = 0
  while start < last
      left = s[start]
      right = s[last]
      if left != right
          return false if deletions > 0
          if s[last - 1] == left
              last -= 1
              deletions += 1
          elsif s[start + 1] == right
              start += 1
              deletions += 1
          else
              return false
          end
      else
          start += 1
          last -= 1
      end
  end
  return true
end


valid_palindrome("aguokepatgbnvfqmgmlcupuufxoohdfpgjdmysgvhmvffcnqxjjxqncffvmhvgsymdjgpfdhooxfuupuculmgmqfvnbgtapekouga")
