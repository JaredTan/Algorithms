def check_valid_string(string)
  stack = []
  stars = 0
  last_left_idx = 0
  string.each_char do |char|
    if char == '('
      stack.push(char)
    elsif char == ')'
      return false if stack.empty?
      new_stack = remove_last_left(stack)
      stack = new_stack
    elsif char == '*'
      stack.push('*')
      stars += 1
    end
  end
  length = 0
  stack.each do |char|
    if char == '('
      length += 1
    else
      length = [length - 1, 0].max
    end
  end
  return length == 0
end
#
# check_valid_string('(())((())()()(*)(*()(())())())()()((()())((()))(*')
# check_valid_string('(*()')

def remove_last_left(stack)
  i = stack.length - 1
  while i > 0 && stack[i] != '('
    i -= 1
  end
  return stack[0...i] + stack[i+1..-1]
end
