class SkipListNode
  attr_reader :value
  def initialize(value, downNode, rightNode)
    @value = value
    @downNode = downNode
    @rightNode = rightNode
    @random = Random.new
  end

  def include?(item)
    return true if item == @value
    return false if item < @value
    return false if @rightNode.nil?
    if @rightNode.value > item
      return false if @downNode.nil
      return @downNode.include?(item)
    end
    @rightNode.include?(item)
  end

  def insert(item)
    return @rightNode.insert(item) if value < item && @rightNode && @rightNode.value <= item
    if @downNode
      [insertHere, newNode] = @downNode.insert(item)
      return [@random.rand(1.0) > 0.5, placeNext(item, newNode)] if insertHere
      return [false, nil]
    end
    [@random.rand(1.0) > 0.5, placeNext(item, nil)]
  end

  def placeNext(item, downNodeLink)
    @rightNode = SkipListNode.new(item, downNodeLink, @rightNode)
  end

  def delete(item)
    return removeThis() if item == @value
    return false if @rightNode.nil?
    return @downNode.delete(item) if @rightNode.value > item && @downNode
    return @rightNode.delete(item)
    false
  end

# removes this, and all children of this
  def removeThis()
  end
  
end