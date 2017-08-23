class DynamicProgramming

  def initialize
    @cache = {1=> 1, 2=> 2}
    @frog_cache = {1=>[[1]], 2=>[[1, 1], [2]], 3 => [[1, 1, 1], [1, 2], [2, 1], [3]] }
    @super_cache = { 1 => [[1]] }

  end

  def blair_nums(n)
    return @cache[n] if @cache[n]
    result = blair_nums(n - 1) + blair_nums(n - 2) + (((n - 1)*2)-1)
    @cache[n] = result
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    cache = {1=>[[1]], 2=>[[1, 1], [2]], 3 => [[1, 1, 1], [1, 2], [2, 1], [3]] }
    (4..n).each do |num|
      new_hops = []
      cache[num - 3].each do |hops|
        cache[3].each do |base_hops|
          new_hops << hops + base_hops unless new_hops.include?(hops + base_hops)
        end
      end
      cache[num - 2].each do |hops|
        cache[2].each do |base_hops|
          new_hops << hops + base_hops unless new_hops.include?(hops + base_hops)
        end
      end
      cache[num - 1].each do |hops|
        cache[1].each do |base_hops|
          new_hops << hops + base_hops unless new_hops.include?(hops + base_hops)
        end
      end
    cache[num] = new_hops
    end
    cache
  end

  def frog_hops_top_down(n)
    return @frog_cache[n] if @frog_cache[n]
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    new_hops = []
    frog_hops_top_down(n - 3).each do |hops|
      @frog_cache[3].each do |base_hops|
        new_hops << hops + base_hops unless new_hops.include?(hops + base_hops)
      end
    end
    frog_hops_top_down(n - 2).each do |hops|
      @frog_cache[2].each do |base_hops|
        new_hops << hops + base_hops unless new_hops.include?(hops + base_hops)
      end
    end
    frog_hops_top_down(n - 1).each do |hops|
      @frog_cache[1].each do |base_hops|
        new_hops << hops + base_hops unless new_hops.include?(hops + base_hops)
      end
    end
    @frog_cache[n] = new_hops
  end

  def super_frog_hops(n, k)
    super_cache = { 1 => [[1]]}
    super_cache = create_n_bases_cache(n, super_cache)
      if k > n
        return super_cache[n]
      else
        ((k+1)..n).each do |num3|
          new_hops = []
          (1..k).each do |num4|
            super_cache[num3 - num4].each do |hops|
              super_cache[num4].each do |base_hops|
                new_hops << hops + base_hops unless new_hops.include?(hops + base_hops)
              end
            end
          end
          super_cache[num3] = new_hops
        end
      end
      super_cache[n]
  end

  def create_n_bases_cache(n, super_cache)
    (2..n).each do |num|
      new_hops = []
      (1..num - 1).each do |num2|
        super_cache[num2].each do |hops|
          super_cache[num - num2].each do |base_hops|
            new_hops << hops + base_hops unless new_hops.include?(hops + base_hops)
          end
        end
      end
      super_cache[num] = new_hops + [[num]]
    end
    return super_cache
  end

  def knapsack(weights, values, capacity)
    table = knapsack_table(weights, values, capacity)
    table[weights.length][capacity]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    num_items = weights.length
    weight_val_hash = {}
    (0..num_items - 1).each do |i|
      weight_val_hash[i] = [weights[i], values[i]]
    end
    table = Array.new(num_items + 1) { Array.new(capacity + 1)}
    table[0].each_with_index do |val, weight|
      table[0][weight] = 0
    end
    (1..num_items).each do |i|
      weight, value = weight_val_hash[i - 1]
      (0..capacity).each do |j|
        if weight > j
          table[i][j] = table[i-1][j]
        else
          table[i][j] = [table[i-1][j], table[i-1][j - weight] + value].max
        end
      end
    end
    return table
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
