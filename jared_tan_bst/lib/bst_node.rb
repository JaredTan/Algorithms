class BSTNode
  attr_reader :value, :depth
  attr_accessor :left, :right, :parent
  def initialize(value, parent = nil)
    @value = value
    @left = nil
    @right = nil
    @parent = parent
  end
end
