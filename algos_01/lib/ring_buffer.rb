require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @start_idx = 0
  end

  # O(1)
  def [](index)
    index < @length ? @store[@start_idx + index] : raise("index out of bounds")
  end

  # O(1)
  def []=(index, val)
    @store[@start_idx + index] = val
  end

  # O(1)
  def pop
    raise("index out of bounds") if @length == 0
    el = self[@length - 1]
    self[@length - 1] = nil
    @length -= 1
    el
  end

  # O(1) ammortized
  def push(val)
    self.resize! if @length == @capacity
    @store[@start_idx + @length] = val
    @length += 1
    val
  end

  # O(1)
  def shift
    raise("index out of bounds") if @length == 0
    el = self[0]
    self[0] = nil
    @start_idx += 1
    @length -= 1
    el
  end

  # O(1) ammortized
  def unshift(val)
    self.resize! if @length == @capacity
    @length += 1
    @start_idx -= 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
  end

  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    (0...@length).each do |i|
      new_store[@start_idx + i] = @store[@start_idx + i]
    end
    @store = new_store
  end
end
