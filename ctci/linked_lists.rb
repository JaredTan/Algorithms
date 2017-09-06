def intersecting_nodes(l1, l2)
  return nil if l1.head.nil? || l2.head.nil?
  length1 = 0
  current_node1 = l1.head
  while current_node1
    length1 += 1
    if !current_node1.next
      last1 = current_node1
    end
    current_node1 = current_node1.next
  end
  length2 = 0
  current_node2 = l2.head
  while current_node2
    length2 += 1
    if !current_node2.next
      last2 = current_node2
    end
    current_node2 = current_node2.next
  end

  return nil if last1 != last2

  if length1 >= length2
    longer = l1
    shorter = l2
  else
    shorter = l1
    longer = l2
  end

  length_diff = (l2 - l1).abs

  skips = 0
  start_node1 = longer.head
  while skips < length_diff
    start_node1 = start_node1.next
    skips += 1
  end

  start_node2 = shorter.head
  while start_node1 != start_node2
    start_node1 = start_node1.next
    start_node2 = start_node2.next
  end
  return start_node1
end


def loop_detection(list)
  slow = list.head
  fast = list.head

  #find the collision point = no matter what it will be at loop-size - k nodes away (asusming looped)
  while fast && fast.next
    fast = fast.next.next
    slow = slow.next
    break if fast == slow
  end

  return false if fast.nil? || fast.next.nil?

  #fast and slow are collided at k nodes from the start

  fast = list.head
  while fast != slow
    fast = fast.next
    slow = slow.next
  end
  return fast
end





end
