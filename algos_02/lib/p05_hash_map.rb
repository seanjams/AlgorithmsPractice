require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  include Enumerable

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if include?(key)
      bucket(key).update(key, val)
    else
      resize! unless @count < num_buckets
      bucket(key).append(key, val)
      @count += 1
    end
    val
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    if get(key)
      bucket(key).remove(key)
      @count -= 1
    end
  end

  def each
    @store.each do |list|
      current_node = list.head
      until current_node == list.last
        current_node = current_node.next
        yield(current_node.key, current_node.val)
      end
    end
    @store
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(2 * num_buckets) { LinkedList.new }
    @store.each do |bucket|
      bucket.each do |node|
        new_store[node.key.hash % (2 * num_buckets)].append(node.key, node.val)
      end
    end
    @store = new_store
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
