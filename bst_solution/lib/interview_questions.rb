# Post Order Traversal:
def post_order_traversal(tree_node, arr = [])
  post_order_traversal(tree_node.left, arr) if tree_node.left
  post_order_traversal(tree_node.right, arr) if tree_node.right
  arr.push(tree_node.value)
  arr
end

# Pre Order Traversal:
def pre_order_traversal(tree_node, arr = [])
  arr.push(tree_node.value)
  pre_order_traversal(tree_node.left, arr) if tree_node.left
  pre_order_traversal(tree_node.right, arr) if tree_node.right
  arr
end


# LCA:
# In a binary search tree, an *ancestor* of a `example_node` is a node
# that is on a higher level than `example_node`, and can be traced directly
# back to `example_node` without going up any levels. (I.e., this is
# intuitively what you think an ancestor should be.) Every node in a binary
# tree shares at least one ancestor -- the root. In this exercise, write a
# function that takes in a BST and two nodes, and returns the node that is the
# lowest common ancestor of the given nodes. Assume no duplicate values.

def lowest_common_ancestor(tree, node_one, node_two)
  if node_one.value > node_two.value
    node_one, node_two = node_two, node_one
  end
  current_node = tree.root
  prc = Proc.new { |i, j| i.value <=> j.value }

  until prc.call(node_one, current_node) + prc.call(node_two, current_node) == 0
    if node_one.right == node_two || node_two.left == node_one
      # return
    end
    if prc.call(first_val, current_val) > 0
      current_node = current_node.left
    else
      current_node = current_node.right
    end
  end
  current_node
end
