class SkipListNode
  attr_reader :value
  def initialize(value, downNode, rightNode)
    @value = value
    @downNode = downNode
    @rightNode = rightNode
  end

  def include?(item)
    return true if item == @value
    return false if item > @value
    return false if @rightNode.nil?
    if @rightNode.value > item
      return false if @downNode.nil
      return @downNode.include?(item)
    end
    @rightNode.include?(item)
  end

  def insert(item)
  end

  def delete(item)
  end
  
end