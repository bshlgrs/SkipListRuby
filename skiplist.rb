class SkipList
  def initialize(n)
    @levels = []*(n-1)
    @totalLevels = (n-1)
  end

  # levels are from base upwards
  # Each item in non 0 levels is [value, (links between it and next one for each level)]

  def makeFromList(list)
    result = SkipList.new()
    list.each.do |item|
      result.insert(item)
    end
    result
  end

  def atIndex(idx)
    @levels[0][idx]
    # lev = @totalLevels
    # cIdx = 0
    # result = nil
    # while result.nil?
    #   if @levels[lev].empty?
    #     result = -1 if lev== 0
    #     lev -= 1
    #   end

    #   if idx == 0
    #     result = @levels[lev][0][0] 
    #   elsif (idx + 1) < @levels[lev][0][1][0] 
    #     # drop down a level, keep going
    #     # lev -= 1
    #     # cIdx = 
    #     # @levels[lev][0][1][0] 
    #   else
    #     # go one across on this level, keep going
    #   end
    # end
    # result
  end

  def include?(item)
  end

  def insert(item)
  end

  def delete(item)
  end

  
end