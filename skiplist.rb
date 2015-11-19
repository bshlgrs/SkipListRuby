class SkipList
  def initialize(n)
    @levels = []*n
    @n = n
  end

  # levels are from base upwards
  # Each item in non 0 levels is [value, (links between it an previous one for each level)]

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

  def atIndex(idx)
  end
end