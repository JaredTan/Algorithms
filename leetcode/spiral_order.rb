# @param {Integer[][]} matrix
# @return {Integer[]}
def spiral_order(matrix, res = [])
    return res if matrix.empty?
    n = matrix.length
    m = matrix[0].length
    matrix[0].each {|el| res << el}
    if n > 1
      i = 1
        while i < n
            res << matrix[i][m-1]
            i += 1
        end
    end
    if m > 1 && n > 1
      j = m - 2
        while j >= 0
            res << matrix[n - 1][j]
            j -= 1
        end
    end
    if n > 1 && m > 1
      i = n - 2
      while i > 0
        res << matrix[i][0]
        i -= 1
      end
    end
    new_matrix = []
    (1...(n - 1)).each do |i|
        new_row = []
        (1...(m-1)).each do |j|
            new_row << matrix[i][j]
        end
        new_matrix << new_row unless new_row.empty?
    end
    return spiral_order(new_matrix, res)
end

[1]
