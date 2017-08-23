class Array

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |el1, el2| el1 <=> el2 }
    pivot_idx = start
    pivot = array[start]
    ((start + 1)...(start + length)).each do |idx|
      if prc.call(pivot, array[idx]) > 0
        array[idx], array[pivot_idx + 1] = array[pivot_idx + 1], array[idx]
        pivot_idx += 1
      end
    end
    array[start], array[pivot_idx] = array[pivot_idx], array[start]
    pivot_idx
  end

  def select_kth_smallest(k)
    prc = Proc.new { |i, j| i <=> j }
    pivot_idx = Array.partition(self, 0, length, &prc)
    until pivot_idx == k
      if prc.call(k, pivot_idx) < 1
        pivot_idx = Array.partition(self, 0, pivot_idx, &prc)
      else
        pivot_idx = Array.partition(self, pivot_idx + 1, length - pivot_idx, &prc)
      end
    end
    self[pivot_idx]
  end
end

arr = [1,4,2,5,3,5]
p arr.select_kth_smallest(1)
p arr.select_kth_smallest(2)
p arr.select_kth_smallest(3)
p arr.select_kth_smallest(4)
p arr.select_kth_smallest(5)
p arr.select_kth_smallest(6)
