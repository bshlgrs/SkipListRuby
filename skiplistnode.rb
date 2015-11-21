class SkipListNode
  attr_reader :value
  attr_accessor :rightNode, :leftNode, :downNode
  def initialize(value, downNode, rightNode, leftNode)
    @value = value
    @downNode = downNode
    @rightNode = rightNode
    @leftNode = leftNode
    @elems_to_next = 0
    @random = Random.new
  end

  def include?(item)
    return true if item == @value
    return false if @value && item < @value
    return false if @value.nil? && @rightNode.nil?
    return @downNode && @downNode.include?(item) if @rightNode.nil? || @rightNode.value > item
    @rightNode.include?(item)
  end

  def insert(item)
    return @rightNode.insert(item) if (value.nil? || value < item) && @rightNode && @rightNode.value <= item
    if @downNode
      insertHere, newNode = @downNode.insert(item)
      return [@random.rand(1.0) > 0.5, placeNext(item, newNode)] if insertHere
      return [false, nil]
    end
    [@random.rand(1.0) > 0.5, placeNext(item, nil)]
  end

  def placeNext(item, downNodeLink)
    newNode = SkipListNode.new(item, downNodeLink, @rightNode, self)
    @rightNode.leftNode = newNode if @rightNode
    @rightNode = newNode
    @rightNode.set_elems_to_next
    newNode.set_elems_to_next
    @rightNode
  end

  def set_elems_to_next()
    @elems_to_next = 1 if @downNode.nil? 
    finishNode = nil
    finishNode = @rightNode.downNode if @rightNode
    currentNode = @downNode
    sum = 0
    while currentNode != finishNode
      sum += currentNode.elems_to_next
      currentNode = currentNode.rightNode
    end
    @elems_to_next = sum
  end

  def delete(item)
    return removeThis() if item == @value
    return false if @value && item < @value
    return false if @value.nil? && @rightNode.nil?
    return @rightNode.delete(item) if @rightNode && @rightNode.value <= item
    return @downNode.delete(item) if @downNode
    false
  end

# removes this, and all downNodes of this
  def removeThis()
    @leftNode.rightNode = @rightNode
    @rightNode.leftNode = @leftNode
    @downNode.removeThis() if @downNode
  end

  def atIndex(idx)
    return @value if idx == 0
    return @rightNode.value if idx == @elems_to_next
    return @rightNode.atIndex(idx) if idx < @elems_to_next
    @rightNode.atIndex(idx - @elems_to_next)
  end
  
end






