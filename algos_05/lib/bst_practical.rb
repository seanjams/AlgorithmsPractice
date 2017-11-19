# require 'binary_search_tree'


def kth_largest(tree_node, k)
  k_largest = reverse_order_traversal(tree_node, [], k)
  k_largest[k - 1]
end

def reverse_order_traversal(tree_node, arr, k)
  return nil if tree_node.nil?
  return arr if arr.length >= k
  reverse_order_traversal(tree_node.right, arr, k)
  arr.push(tree_node)
  reverse_order_traversal(tree_node.left, arr, k)
  arr
end

#############################
# prefilled_bst looks like: #
#             (5)           #
#            /   \          #
#          (3)   (7)        #
#         /  \      \       #
#      (1)   (4)    (9)     #
#     /   \            \    #
#   (0)   (2)          (10) #
#        /                  #
#      (1.5)                #
#############################
