# Definition for singly-linked list.
# class ListNode
#     attr_accessor :val, :next
#     def initialize(val)
#         @val = val
#         @next = nil
#     end
# end

# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {ListNode} head
# @return {TreeNode}
def sorted_list_to_bst(head)
    arr = []
    while head
        arr << head.val
        head = head.next
    end
    return if arr.length == 0
    mid = arr.length / 2
    head = TreeNode.new(arr[mid])
    recurse_through_tree(arr, head)
    return head
end

def recurse_through_tree(arr, tree_node)
    return if arr.length == 0
    mid = arr.length / 2
    left_mid = arr[0...mid].length / 2
    right_mid = mid + 1 + (arr[(mid + 1)..-1].length / 2)
    if arr[0...mid].length > 0
        left_node = TreeNode.new(arr[left_mid])
        tree_node.left = left_node
        recurse_through_tree(arr[0...mid], left_node) if arr[0...mid].length > 1
    end
    if arr[(mid + 1)..-1].length > 0
        right_node = TreeNode.new(arr[right_mid])
        tree_node.right = right_node
        recurse_through_tree(arr[(mid + 1)..-1], right_node) if arr[(mid + 1)..-1].length > 1
    end
end
