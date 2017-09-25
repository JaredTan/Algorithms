def two_sum(numbers, target)
   p1 = 0
    p2 = 1
    while p1 < numbers.length - 1
      return [p1 + 1, p2 + 1] if numbers[p1] + numbers[p2] == target
      while numbers[p2] == numbers[p2 + 1]
        p1 += 1
        p2 += 1
      end
        while p2 < numbers.length
            return [p1 + 1, p2 + 1] if numbers[p1] + numbers[p2] == target
            if numbers[p1] + numbers[p2] > target
                break
            else
                p2 += 1
            end
        end
        p1 += 1
        p2 = p1 + 1
    end
    return nil
end
