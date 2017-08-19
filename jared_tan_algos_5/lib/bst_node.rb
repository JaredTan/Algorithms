class BSTNode
  attr_reader :value, :depth
  attr_accessor :left, :right, :parent
  def initialize(value, parent = nil, depth = 0)
    @value = value
    @left = nil
    @right = nil
    @parent = parent
    @depth = depth
  end
end
