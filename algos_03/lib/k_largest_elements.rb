require_relative 'heap'

def k_largest_elements(array, k)
  array.heap_sort!
  array[(array.length - k)..-1]
end
