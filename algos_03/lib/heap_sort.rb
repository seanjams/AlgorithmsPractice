require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new { |p,c| c <=> p }
    length = self.length
    (1...length).each do |i|
      BinaryMinHeap.heapify_up(self, i, &prc)
    end
    (1...length).each do |i|
      self[0], self[length - i] = self[length - i], self[0]
      BinaryMinHeap.heapify_down(self, 0, length - i, &prc)
    end
  end
end
