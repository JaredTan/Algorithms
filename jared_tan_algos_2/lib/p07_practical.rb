require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  map = HashMap.new
  string.each_char do |ch|
    if map[ch]
      map.delete(ch)
    else
      map[ch] = true
    end
  end

  map.count <= 1
end
