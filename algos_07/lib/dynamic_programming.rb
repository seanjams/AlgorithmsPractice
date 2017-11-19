require 'byebug'

class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = { 1 => [[1]],
              2 => [[1,1], [2]],
              3 => [[1,1,1], [1,2], [2,1], [3]] }
    @super_frog_cache = { 1 => [[1]] }
  end

  def blair_nums(n)
    return @blair_cache[n] if n < 3
    (3..n).each do |k|
      @blair_cache[k] = @blair_cache[k-1] + @blair_cache[k-2] + 2 * (k - 1) - 1
    end
    @blair_cache[n]
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    cache = { 1 => [[1]],
              2 => [[1,1], [2]],
              3 => [[1,1,1], [1,2], [2,1], [3]] }
    return cache if n < 4

    (4..n).each do |i|
      result = []
      cache[i - 1].each do |hops|
        cache[1].each { |skops| result << hops + skops }
      end
      cache[i - 2].each do |hops|
        cache[2].each { |skops| result << hops + skops }
      end
      cache[i - 3].each do |hops|
        cache[3].each { |skops| result << hops + skops }
      end

      cache[i] = result.uniq
    end

    cache
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] unless @frog_cache[n].nil?
    result = []
    (1..3).each do |i|
      frog_hops_top_down_helper(n - i).each do |hops|
        @frog_cache[i].each { |skops| result << hops + skops }
      end
    end
    @frog_cache[n] = result.uniq
  end

  def super_frog_hops(n, k)
    # debugger
    return @super_frog_cache[n] if @super_frog_cache[n]
    
    result = []
    max_stairs = n > k ? k : n
    (1..max_stairs).each do |i|
      if n == i
        result << [i]
        break
      end
      super_frog_hops(n - i, k).each do |hops|
        @super_frog_cache[i].each { |skops| result << hops + skops }
        result << hops + [i]
      end
    end
    @super_frog_cache[n] = result.uniq
  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end

if __FILE__ == $PROGRAM_NAME
  dp = DynamicProgramming.new
  intervals = dp.super_frog_hops(12, 15)
  scales = intervals.map do |interval|
    new_scale = [0]
    interval.map do |int|
      new_scale << new_scale[-1] + int
    end
    new_scale[0...-1]
  end

  (1..12).each do |i|
    puts "length #{i}: #{scales.count { |scale| scale.length == i }}"
  end

  # puts scales.to_s
  # puts dp.super_frog_hops(2,2).sort.to_s

end