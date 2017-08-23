class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot = array[0]
    left, right = [], []
    array[1..-1].each do |el|
      if el <= pivot
        left << el
      else
        right << el
      end
    end
    QuickSort.sort1(left) + [pivot] + QuickSort.sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length <= 1
    prc ||= Proc.new { |i, j| i <=> j }
    pivot_idx = QuickSort.partition(array, start, length, &prc)
    QuickSort.sort2!(array, start, pivot_idx - start, &prc)
    QuickSort.sort2!(array, pivot_idx + 1, length - pivot_idx - 1, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |i, j| i <=> j }
    pivot_idx = start + 1
    (1...length).each do |i|
      if prc.call(array[start + i], array[start]) < 1
        array[start + i], array[pivot_idx] = array[pivot_idx], array[start + i]
        pivot_idx += 1
      end
    end
    array[start], array[pivot_idx - 1] = array[pivot_idx - 1], array[start]
    pivot_idx - 1
  end
end
