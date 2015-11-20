require "./skiplistnode.rb"

class SkipList
  def initialize()
    @firstNode = SkipListNode.new(nil, nil, nil)
  end

  def makeFromList(list)
    result = SkipList.new()
    list.each.do |item|
      result.insert(item)
    end
    result
  end

  def include?(item)
  end

  def insert(item)
  end

  def delete(item)
  end
  
end