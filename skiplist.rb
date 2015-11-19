class SkipList
  def initialize()
  end

  def makeFromList(list)
    result = SkipList.new()
    list.each.do |item|
      result.insert(item)
    end
    result
  end
end