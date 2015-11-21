require "./skiplistnode.rb"

class SkipList
  def initialize()
    @firstNode = SkipListNode.new(nil, nil, nil, nil)
  end

  def include?(item)
    @firstNode.include?(item)
  end

  def insert(item)
    insertHere, newDownNode = @firstNode.insert(item)
    if insertHere
      @firstNode = SkipListNode.new(nil, @firstNode, nil, nil)
      @firstNode.placeNext(item, newDownNode)
    end
  end

  def delete(item)
    @firstNode.delete(item)
  end

  def toLists()
    result = []
    leftMostNode = @firstNode
    while leftMostNode
      list = []
      currentNode = leftMostNode
      while currentNode
        list << currentNode.value
        currentNode = currentNode.rightNode
      end
      result << list
      leftMostNode = leftMostNode.downNode
    end
    result
  end

  def to_a()
    result = []
    currentNode = @firstNode
    while currentNode.downNode
      currentNode = currentNode.downNode
    end
    while currentNode
      result << currentNode.value
      currentNode = currentNode.rightNode
    end
    result
  end

  def first()
  end

  def last()
  end

  def length()
  end

  def each()
  end

end

def fromEnum(enum)
  result = SkipList.new()
  enum.each do |elem|
    result.insert(elem)
  end
  result
end

# test = fromEnum([1,2,3,4,5,6,7,8,9])

# [1,2,3,4,5,6,7,8,9].each do |item|
#   puts "#{item} #{test.include?(item)}"
# end

# [0,-1,10,12,4.5].each do |item|
#   puts "#{item} #{!test.include?(item)}"
# end
