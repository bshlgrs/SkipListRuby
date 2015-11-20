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
end


  # def makeFromList(list)
  #   result = SkipList.new()
  #   list.each.do |item|
  #     result.insert(item)
  #   end
  #   result
  # end


test = SkipList.new()
[1,3,5,12,9,40,12,18,3,4,2,50,108,89,15,17,16].each do |item|
  test.insert(item)
end
p(test.toLists())