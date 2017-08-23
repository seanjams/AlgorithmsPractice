# require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |parent, child| parent <=> child }
  end

  def count
    @store.length
  end

  def extract
    root = @store[0]
    @store[0] = @store.pop
    BinaryMinHeap.heapify_down(@store, 0, &@prc)
    root
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    BinaryMinHeap.heapify_up(@store, self.count - 1, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    child_idx = []
    [2 * parent_index + 1, 2 * parent_index + 2].each do |i|
      child_idx << i if i < len
    end
    child_idx
  end

  def self.parent_index(child_index)
    raise("root has no parent") if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |parent, child| parent <=> child }
    parent = array[parent_idx]
    children = BinaryMinHeap.child_indices(len, parent_idx).map do |i|
      array[i]
    end
    return array if children.empty? || children.all? do |child|
      prc.call(parent, child) <= 0
    end
    child_idx = prc.call(1,2) < 0 ? array.index(children.min) : array.index(children.max)
    array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    BinaryMinHeap.heapify_down(array, child_idx, len, &prc)
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    return array if child_idx == 0
    prc ||= Proc.new { |parent, child| parent <=> child }
    parent_idx = BinaryMinHeap.parent_index(child_idx)
    parent, child = array[parent_idx], array[child_idx]
    return array if prc.call(parent, child) <= 0
    array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
    BinaryMinHeap.heapify_up(array, parent_idx, len, &prc)
  end
end
