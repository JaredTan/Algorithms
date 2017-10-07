def is_match(text, pattern)
  i = 0
  j = 0
  while i < text.length
    return false if !pattern[j]
    if text[i] == pattern[j] || pattern[j] == '.'
      i += 1
      j += 1
    elsif pattern[j] == '*'
      prev_letter = text[i - 1]
      minimum = 0
      k = j + 1
      while pattern[k] == prev_letter
        minimum += 1
        k += 1
      end
      minimum.times do
        return false if text[i] != prev_letter
        i += 1
      end
      while text[i] == prev_letter
        i += 1
      end
      j = k
    else
      return false unless pattern[j + 1] == '*'
      j += 2
    end
  end
  return true if j == pattern.length
  while j < pattern.length
    return false if !pattern[j + 1] || pattern[j + 1] != '*'
    j += 2
  end
  return true
end
