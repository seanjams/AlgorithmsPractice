# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

def install_order(arr)
  new_arr = arr.dup
  queue = []
  max_id = arr.map{ |el| el[0] }.max
  result = (1..max_id).to_a.reject { |el| has_dependency?(arr, el) }

  gather_dependencies = Proc.new do |array|
    array.select! do |el|
      independent = is_independent?(array, result, el[0])
      queue << el if independent
      !independent
    end
  end

  gather_dependencies.call(new_arr)
  while queue.length > 0
    result << queue.shift[0] until queue.empty?
    gather_dependencies.call(new_arr)
  end

  result
end

def has_dependency?(arr, value)
  arr.any? { |el| el[0] == value }
end

def is_independent?(arr, dependencies, value)
  matches = arr.select { |el| el[0] == value }
  matches.all? { |match| dependencies.include?(match[1]) }
end
