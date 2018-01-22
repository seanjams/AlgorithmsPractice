require 'byebug'

class Array

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

  def select_kth_smallest(k)
    # debugger
    pivot_idx = Array.partition(self, 0, self.length)
    i = 0
      if pivot_idx < k
        pivot_idx = Array.partition(self, pivot_idx, self.length - pivot_idx)
      elsif pivot_idx > k
        pivot_idx = Array.partition(self, 0, pivot_idx)
      else
        return pivot_idx
      end
      i += 1
    end
    return pivot_idx
  end

end

arr = [1,4,2,5,3,5]
p arr.select_kth_smallest(1)
p arr.select_kth_smallest(2)
p arr.select_kth_smallest(3)
p arr.select_kth_smallest(4)
p arr.select_kth_smallest(5)
p arr.select_kth_smallest(6)
