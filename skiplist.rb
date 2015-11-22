require "./skiplistnode.rb"

class SkipList
  def initialize()
    @first_node = SkipListNode.new(nil, nil, nil, nil)
  end

  def include?(item)
    @first_node.include?(item)
  end

  def insert(item)
    insert_here, new_down_node = @first_node.insert(item)
    if insert_here
      @first_node = SkipListNode.new(nil, @first_node, nil, nil)
      @first_node.place_next(item, new_down_node)
      new_down_node.set_elems_to_next
      @first_node.set_elems_to_next
    end
  end

  def [](idx)
    return nil if idx < 0
    @first_node.at_index(idx+1)
  end

  def delete(item)
    @first_node.delete(item)
  end

  def to_lists()
    result = []
    left_most_node = @first_node
    while left_most_node
      list = []
      current_node = left_most_node
      while current_node
        list << current_node.value
        current_node = current_node.right_node
      end
      result << list
      left_most_node = left_most_node.down_node
    end
    result
  end

  # def to_lists_elems()
  #   result = []
  #   left_most_node = @first_node
  #   while left_most_node
  #     list = []
  #     current_node = left_most_node
  #     while current_node
  #       list << current_node.elems_to_next
  #       current_node = current_node.right_node
  #     end
  #     result << list
  #     left_most_node = left_most_node.down_node
  #   end
  #   result
  # end

  def to_a()
    result = []
    current_node = @first_node
    while current_node.down_node
      current_node = current_node.down_node
    end
    while current_node
      result << current_node.value
      current_node = current_node.right_node
    end
    result
  end

  def first()
    current_node = @first_node
    while current_node.down_node
      current_node = current_node.down_node
    end
    return current_node.right_node.value if current_node.right_node
    nil
  end

  def last()
    current_node = @first_node
    while current_node.right_node || current_node.down_node
      while current_node.right_node
        current_node = current_node.right_node
      end
      current_node = current_node.down_node if current_node.down_node
    end
    current_node.value
  end

  def length()
  end

  def each()
    to_a.each()
  end

end

def from_enum(enum)
  result = SkipList.new()
  enum.each do |elem|
    result.insert(elem)
  end
  result
end

test = from_enum([1,2,3,4,5,6,7,8,9])
p(test.to_lists)
# puts "----------------"
# p(test.to_lists_elems)
(0..8).each do |idx|
  puts test[idx]
end

# [1,2,3,4,5,6,7,8,9].each do |item|
#   puts "#{item} #{test.include?(item)}"
# end

# [0,-1,10,12,4.5].each do |item|
#   puts "#{item} #{!test.include?(item)}"
# end
