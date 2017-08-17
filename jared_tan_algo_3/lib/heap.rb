class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc || Proc.new { |a, b| a <=> b }
  end

  def count
    @store.length
  end

  def extract
    el = @store[0]
    if count > 1
      store[0] = store.pop
      self.class.heapify_down(store, 0, &prc)
    else
      store.pop
    end

    el
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    self.class.heapify_up(@store, count - 1, @prc)
  end

  public
  def self.child_indices(len, parent_index)
    [2 * parent_index + 1, 2 * parent_index + 2].select { |i| i < len }
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }
    left_child_idx, right_child_idx = child_indices(len, parent_idx)

    parent_val = array[parent_idx]

    children = []
    children << array[left_child_idx] if left_child_idx
    children << array[right_child_idx] if right_child_idx

    if children.all? { |child| prc.call(parent_val, child) <= 0}
      return array
    end

    swap = 0
    if children.length == 1
      swap = left_child_idx
    else
      if prc.call(children[0], children[1]) == -1
        swap = left_child_idx
      else
        swap = right_child_idx
      end
    end

    array[parent_idx], array[swap] = array[swap], parent_val
    heapify_down(array, swap, len, &prc)

  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |a, b| a <=> b }

    return array if child_idx == 0

    parent_idx = parent_index(child_idx)
    child_val, parent_val = array[child_idx], array[parent_idx]
    if prc.call(child_val, parent_val) >= 0
      return array
    else
      array[child_idx], array[parent_idx] = parent_val, child_val
      heapify_up(array, parent_idx, len, &prc)
    end
  end
end
