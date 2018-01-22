require 'byebug'

class DynamicProgramming
  DELTAS = [[1,0], [0,1], [-1,0], [0,-1]]

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = { 1 => [[1]],
              2 => [[1,1], [2]],
              3 => [[1,1,1], [1,2], [2,1], [3]] }
    @maze_cache = nil
  end

  def [](pos)
    @maze_cache[pos[0]][pos[1]]
  end

  def []=(pos,val)
    @maze_cache[pos[0]][pos[1]] = val
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

  def super_frog_hops(n,k)
    cache = super_frog_cache_builder(n, k)
    cache[n]
  end

  def super_frog_cache_builder(n, k)
    cache = { 1 => [[1]] }
    return cache if n < 2
    
    (2..n).each do |j|
      result = []
      max_stairs = j > k ? k : j
      (1..max_stairs).each do |i|
        if j == i
          result << [i]
          break
        end
        cache[j - i].each do |hops|
          cache[i].each { |skops| result << hops + skops }
          result << hops + [i]
        end
      end
      cache[j] = result.uniq
    end
    cache
  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def display_maze(maze)
    puts "--" * maze[0].length
    maze.each { |row|
      puts row.map { |ch|
        # puts ch
        if ch.is_a?( Array ) 
          return "A"
        else
          return ch
        end
      }.join(" ")
    }
    puts "--" * maze[0].length
  end

  def maze_solver(maze, start_pos, finish_pos)
    debugger
    # display_maze(maze)
    return self[start_pos] = [finish_pos] if start_pos == finish_pos
    if @maze_cache.nil?
      @maze_cache = maze.dup.map { |row| row.dup }
    end

    neighbors = valid_neighbors(start_pos)
  
    potential_paths = neighbors.select { |pos|
      self[pos] = "L" if self[pos] == " "
      maze_solver(maze, pos, finish_pos).is_a?( Array )
    }.map { |pos| self[pos] }
    
    if potential_paths.empty?
      self[start_pos] = " "
      return nil
    end

    min_path = potential_paths.sort_by(&:length)[0]
    
    self[start_pos] = [start_pos].concat(min_path)

    return self[start_pos]
  end

  private

  def valid_neighbors(pos)
    neighbors = DELTAS.map do |d|
      [pos[0] + d[0], pos[1] + d[1]]
    end
    neighbors.select do |neighbor|
      in_range?(neighbor) && [" ", "F"].include?(@maze_cache[neighbor[0]][neighbor[1]])
    end
  end

  def in_range?(pos)
    lengths = []
    lengths[0] = @maze_cache.length
    lengths[1] = @maze_cache[0].length
    [0,1].all? do |i|
      pos[i] >= 0 && pos[i] < lengths[i]
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  dp = DynamicProgramming.new
  # intervals = dp.super_frog_hops(12, 15)
  # scales = intervals.map do |interval|
  #   new_scale = [0]
  #   interval.map do |int|
  #     new_scale << new_scale[-1] + int
  #   end
  #   new_scale[0...-1]
  # end

  # (1..12).each do |i|
  #   puts "length #{i}: #{scales.count { |scale| scale.length == i }}"
  # end

  # puts scales.to_s
  # puts dp.super_frog_hops(2,2).sort.to_s

  maze = [
    ['X', 'X', 'X', ' ', 'X', 'X', 'F', 'X'],
    ['X', 'S', 'X', ' ', 'X', 'X', ' ', 'X'],
    ['X', ' ', ' ', ' ', ' ', ' ', ' ', ' '],
    ['X', 'X', 'X', ' ', 'X', 'X', ' ', 'X'],
    ['X', ' ', ' ', ' ', ' ', ' ', ' ', 'X'],
    ['X', 'X', 'X', 'X', 'X', 'X', 'X', 'X']
  ] 

  dp.maze_solver(maze, [1,1], [0,6]).each { |pos| puts pos.to_s }
end
