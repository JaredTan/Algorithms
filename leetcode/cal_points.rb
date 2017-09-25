def cal_points(ops)
    valid_vals = []
    total = 0
    ops.each do |op|
        if op =='C'
            total -= (valid_vals.last || 0)
            valid_vals.pop if valid_vals.length > 0
        elsif op =='D'
            total += ((valid_vals[-1] || 0) * 2)
            valid_vals.push(((valid_vals[-1] || 0) * 2))
        elsif op == '+'
            total += ((valid_vals[-2] || 0) + (valid_vals[-1] || 0))
            valid_vals.push((valid_vals[-2] || 0) + (valid_vals[-1] || 0))
        else
            valid_vals.push(op.to_i)
            total += op.to_i
        end
    end
    total
end
