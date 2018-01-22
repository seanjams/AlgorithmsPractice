require 'byebug'

class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length <= 1
    pivot, left, right = array[0], [], []
    (1...array.length).each do |i|
      if (arr[i] < pivot)
        left << arr[i]
      else
        right << arr[i]
      end
    end
    sort1(left) + [pivot] + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    return array if length <= 1
    pivot_idx = partition(array, start, length, &prc)
    sort2!(array, start, pivot_idx - start, &prc)
    sort2!(array, pivot_idx + 1, length - 1 - pivot_idx + start, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    return 0 if length <= 1
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    # debugger
    pivot_idx = start
    pivot = array[start]
    (length - 1).times do |i|
      idx = start + i + 1
      if prc.call(array[idx], pivot) < 0
        temp = array[idx]
        array[idx] = array[pivot_idx + 1]
        array[pivot_idx + 1] = pivot
        array[pivot_idx] = temp
        pivot_idx += 1
      end
    end
    pivot_idx
  end

end
