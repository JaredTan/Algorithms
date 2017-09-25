# @param {String} time
# @return {String}
def next_closest_time(time)
    nums = []
    time.each_char do |string|
        nums.push string.to_i if string != ':'
    end
    seconds = time[-1].to_i
    lowest_num = nums.min
    lowest_seconds_num = lowest_num(seconds, nums)
    return time[0,2] + ':' + time[3] + lowest_seconds_num.to_s if lowest_seconds_num
    minutes = time[-2].to_i
    lowest_minutes_num = lowest_minutes_num(minutes, nums)
    return time[0,2] + ':' + lowest_minutes_num.to_s + lowest_num.to_s  if lowest_minutes_num

    hours = time[0,2].to_i
    lowest_hours_num = next_hours_num(hours, nums)
    if lowest_hours_num
        if lowest_hours_num < 10
            return '0' + lowest_hours_num.to_s + ':' + lowest_num.to_s + lowest_num.to_s
        else
            return lowest_hours_num.to_s + ':' + lowest_num.to_s + lowest_num.to_s
        end
    else
        return lowest_num.to_s + lowest_num.to_s + ':' + lowest_num.to_s + lowest_num.to_s
    end
end

def lowest_num(n, all)
    lowest = nil
    all.each do |num|
        if lowest
         lowest = num if num > n && num < lowest
        else
            lowest = num if num > n
        end
    end
    lowest
end

def lowest_minutes_num(n, all)
    lowest = nil
    filtered = all.select{|num| num < 6}
    filtered.each do |num|
        if lowest
         lowest = num if num > n && num < lowest
        else
            lowest = num if num > n
        end
    end
    lowest
end

def next_hours_num(hour, all)
    lowest = nil
    if hour >= 20
        filtered_four = all.select{|num| num < 4}
        filtered_four.each do |num|
          if lowest
           lowest = 20 + num if 20 + num > hour && 20 + num < lowest
          else
              lowest = 20 + num if 20 + num > hour
          end
        end
        return lowest ? lowest : nil
    elsif hour < 20 && hour >= 10
        all.each do |num|
            if lowest
             lowest = 10 + num if 10 + num > hour && 10 + num < lowest
            else
                lowest = 10 + num if 10 + num > hour
            end
        end
         return lowest ? lowest : nil
    else
        all.each do |num|
            if lowest
             lowest = num if num > hour && num < lowest
            else
              lowest = num if num > hour
            end
        end
        return lowest ? lowest : nil
    end


end
