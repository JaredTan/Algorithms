class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    result = 16
    self.each do |el|
      result = result / el + (483294*el) if el.is_a?(Integer)
      result = result / el[0].hash*4 + (483294*el.hash) if el.is_a?(Array)
    end
    result
  end
end

class String
  def hash
    letters = ('a'..'z').to_a
    result = 13
    self.each_char do |ch|
      if letters.include?(ch.downcase)
        result *= 3 + (letters.index(ch.downcase) + 2) + (letters.index(ch.downcase)+1) + 949
        result /= (letters.index(ch.downcase) + 2)
      end
    end
    result
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    result = 542315
    self.keys.each do |key|
      if key.is_a?(Symbol)
        result *= key.to_s.hash
        result *= (self[key].hash + 18 )
      end
      if key.is_a?(Integer) || key.is_a?(String)
        result *= key.hash
        result = result * self[key].hash / 4314
      end
    end
    result
  end
end
