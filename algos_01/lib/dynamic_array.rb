require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @length = 0
    @capacity = 8
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    index < @length ? @store[index] : raise("index out of bounds")
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    raise("index out of bounds") if @length == 0
    el = self[@length - 1]
    self[@length - 1] = nil
    @length -= 1
    el
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    self.resize! if @length == @capacity
    @store[@length] = val
    @length += 1
    val
  end

  # O(n): has to shift over all the elements.
  def shift
    raise("index out of bounds") if @length == 0
    el = self[0]
    # new_store = StaticArray.new(@capacity)
    (1...@length).each do |i|
      @store[i-1] = @store[i]
    end
    @store[@length - 1] = nil
    @length -= 1
    el
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    self.resize! if @length == @capacity
    (0...@length).to_a.reverse.each do |i|
      @store[i+1] = @store[i]
    end
    @store[0] = val
    @length += 1
    val
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)

  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    (0...@length).each do |i|
      new_store[i] = @store[i]
    end
    @store = new_store
  end
end
