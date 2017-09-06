You are given two non-empty linked lists representing two non-negative integers.
The digits are stored in reverse order and each of their nodes contain a single digit.
Add the two numbers and return it as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 0 -> 8

def add_two_numbers(list1, list2)
  new_list = LinkedList.new
  current_node_one = list1.first
  current_node_two = list2.first
  carry = 0
  until !current_node_one && !current_node_two && carry == 0
    val_one = current_node_one.val || 0
    val_two = current_node_two.val || 0
    sum = val_one + val_two + carry
    new_list.append(sum % 10 + carry) unless carry == 0 && !current_node_one && !current_node_two
    if sum >= 10
      carry = 1
    else
      carry = 0
    end
  end
  new_list
end
