class BSTNode
  def initialize(value, parent = nil)
    @value = value
    @left = nil
    @right = nil
    @parent = parent
  end

  attr_accessor :left, :right, :parent
  attr_reader :value
end
