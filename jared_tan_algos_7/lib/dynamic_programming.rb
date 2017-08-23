class DynamicProgramming

  def initialize
    @cache = {1=> 1, 2=> 2}
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

  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
