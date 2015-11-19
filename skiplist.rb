class SkipList
  def initialize(n)
    levels = []*n
  end

  def makeFromList(list)
    result = SkipList.new()
    list.each.do |item|
      result.insert(item)
    end
    result
  end

  def insert(item)
  end

  def include?(item)
  end

  def delete(item)
  end
end