class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @next.prev = @prev
    @prev.next = @next
    @next, @prev = nil, nil
  end
end

class LinkedList
  attr_reader :head, :tail

  def initialize
    @head, @tail = Node.new, Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  include Enumerable

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next.key == @tail.key
  end

  def get(key)
    current_node = @head
    until current_node.key == key || current_node == @tail
      current_node = current_node.next
    end
    current_node == @tail ? nil : current_node.val
  end

  def include?(key)
    !!get(key)
  end

  def append(key, val)
    new_node = Node.new(key, val)
    new_node.prev = last
    last.next = new_node
    new_node.next = @tail
    @tail.prev = new_node
  end

  def update(key, val)
    current_node = @head
    until current_node.key == key || current_node == @tail
      current_node = current_node.next
    end
    if current_node != @tail
      current_node.val = val
    end
  end

  def remove(key)
    current_node = @head
    until current_node.key == key || current_node == @tail
      current_node = current_node.next
    end
    current_node.remove if current_node != @tail
  end

  def each
    current_node = @head
    until current_node == last
      current_node = current_node.next
      yield(current_node)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
