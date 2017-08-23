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
    return super_cache[n] if super_cache[n]
      if k > n
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
        p super_cache
        return super_cache[n]
      else
        (2..k).each do |num|
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
        # max_steps (k) < num_stairs (n)

      super_cache[n]

  end


  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
