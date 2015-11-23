class SkipListNode
  attr_reader :value
  attr_accessor :right_node, :left_node, :down_node, :elems_to_next, :elems_set, :up_node
  def initialize(value, down_node, up_node, right_node, left_node)
    @value = value
    @down_node = down_node
    if @down_node
      @down_node.up_node = self
    end
    @up_node = up_node
    @right_node= right_node
    @left_node = left_node
    @elems_to_next = 0
    @elems_set = false
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
    return @right_node.insert(item) if (value.nil? || value < item) && @right_node && @right_node.value <= item
    if @down_node
      insert_here, new_node = @down_node.insert(item)
      if insert_here
        return [@random.rand(1.0) > 0.5, place_next(item, new_node)]
      end
      return [false, nil]
    end
    [@random.rand(1.0) > 0.5, place_next(item, nil)]
  end

  def place_next(item, down_node_link)
    new_node = SkipListNode.new(item, down_node_link, nil, @right_node, self)
    @right_node.left_node = new_node if @right_node
    @right_node = new_node
    set_elems_to_next_upward()
    @right_node.set_elems_to_next_upward_and_left()

    @right_node
  end

  def set_elems_to_next_upward_and_left()
    set_elems_to_next()
    current_node = self
    while current_node && current_node.up_node.nil?
      current_node = current_node.left_node
    end
    current_node.up_node.set_elems_to_next_upward_and_left() if current_node
  end

  def set_elems_to_next_upward()
    set_elems_to_next()
    @up_node.set_elems_to_next_upward() if @up_node
  end

  def set_elems_to_next()
    return @elems_to_next = 0 if @down_node.nil? && !@right_node
    return @elems_to_next = 1 if @down_node.nil? 

    finish_node = nil
    finish_node = @right_node.down_node if @right_node
    current_node = @down_node
    sum = 0
    while (current_node != finish_node) 
      sum += current_node.elems_to_next
      current_node = current_node.right_node
    end
    @elems_to_next = sum
    return @elems_to_next
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






