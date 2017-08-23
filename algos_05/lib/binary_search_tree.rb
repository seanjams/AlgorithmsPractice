# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require 'bst_node'

class BinarySearchTree
  attr_accessor :root

  def initialize(root = nil)
    @root = root
  end

  def insert(value)
    if @root.nil?
      @root = BSTNode.new(value)
    elsif @root.value < value
      if @root.right
        new_right = BinarySearchTree.new(@root.right)
        new_right.insert(value)
        @root.right = new_right.root
      else
        @root.right = BSTNode.new(value, @root)
      end
    elsif @root.value > value
      if @root.left
        new_left = BinarySearchTree.new(@root.left)
        new_left.insert(value)
        @root.left = new_left.root
      else
        @root.left = BSTNode.new(value, @root)
      end
    end
  end

  def find(value, tree_node = @root)
    if (tree_node.value < value) && tree_node.right
      tree_node = tree_node.right
      find(value, tree_node)
    elsif (tree_node.value > value) && tree_node.left
      tree_node = tree_node.left
      find(value, tree_node)
    elsif tree_node.value == value
      tree_node
    else
      return nil
    end
  end

  def delete(value)
    node = find(value)
    if node.right && node.left
      max_node = maximum(node.left)
      if max_node.left
        max_node.parent.right = max_node.left
      end
      max_node.left = node.left
      max_node.right = node.right
      replace(node, max_node)
    elsif node.right || node.left
      node_child = node.right || node.left
      node_child.parent = node.parent
      replace(node, node_child)
    else
      if node.parent
        replace(node, nil)
      else
        @root = nil
      end
    end
    node.parent = nil
    node.right = nil
    node.left = nil
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return nil if tree_node.nil?
    until tree_node.right.nil?
      tree_node = tree_node.right
    end
    tree_node
  end

  def depth(tree_node = @root)
    return -1 if tree_node.nil?
    return 0 if tree_node.right.nil? && tree_node.left.nil?
    [1 + depth(tree_node.left), 1 + depth(tree_node.right)].max
  end

  def is_balanced?(tree_node = @root)
    (depth(tree_node.left) - depth(tree_node.right)).abs < 1
  end

  def in_order_traversal(tree_node = @root, arr = [])
    return nil if tree_node.nil?
    in_order_traversal(tree_node.left, arr)
    arr.push(tree_node.value)
    in_order_traversal(tree_node.right, arr)
    arr
  end

  private
  # optional helper methods go here:
  def replace(node, new_node)
    if node.parent.value < node.value
      node.parent.right = new_node
    else
      node.parent.left = new_node
    end
  end

end
