class SkipListNode
  attr_reader :value
  attr_accessor :right_node, :left_node, :down_node, :elems_to_next
  def initialize(value, down_node, right_node, left_node)
    @value = value
    @down_node= down_node
    @right_node= right_node
    @left_node = left_node
    @elems_to_next = 0
    @random = Random.new
  end

  def include?(item)
    return true if item == @value
    return false if @value && item < @value
    return false if @value.nil? && @right_node.nil?
    return @down_node&& @down_node.include?(item) if @right_node.nil? || @right_node.value > item
    @right_node.include?(item)
  end

  def insert(item)
    return @right_node.insert(item) if (value.nil? || value < item) && @right_node&& @right_node.value <= item
    if @down_node
      insertHere, new_node = @down_node.insert(item)
      if insertHere
        nextNode = place_next(item, new_node)
        nextNode.left_node.set_elems_to_next
        nextNode.set_elems_to_next
        return [@random.rand(1.0) > 0.5, nextNode]
      end
      return [false, nil]
    end
    set_elems_to_next()
    [@random.rand(1.0) > 0.5, place_next(item, nil)]
  end

  def place_next(item, down_node_link)
    new_node = SkipListNode.new(item, down_node_link, @right_node, self)
    @right_node.left_node = new_node if @right_node
    @right_node= new_node
  end

  def set_elems_to_next()
    return @elems_to_next = 1 if @down_node.nil?
    finish_node = nil
    finish_node = @right_node.down_nodeif @right_node
    current_node = @down_node
    sum = 0
    while current_node != finish_node
      sum += current_node.elems_to_next
      current_node = current_node.right_node
    end
    @elems_to_next = sum
  end

  def delete(item)
    return remove_this() if item == @value
    return false if @value && item < @value
    return false if @value.nil? && @right_node.nil?
    return @right_node.delete(item) if @right_node&& @right_node.value <= item
    return @down_node.delete(item) if @down_node
    false
  end

# removes this, and all down_nodes of this
  def remove_this()
    @left_node.right_node= @right_node
    @right_node.left_node = @left_node
    @down_node.remove_this() if @down_node
  end

  def at_index(idx)
    return @value if idx == 0
    return @right_node.value if idx == @elems_to_next && @right_node
    return @down_node.at_index(idx) if (idx < @elems_to_next || @right_node.nil?) && @down_node
    return @right_node.at_index(idx - @elems_to_next) if @right_node
    nil
  end
  
end






