class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    self.each do |link|
      if link.key == key
        return link.val
      end
    end
  end

  def include?(key)
    self.each do |link|
      if link.key == key
        return true
      end
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    @tail.prev.next = new_node
    new_node.prev = @tail.prev
    @tail.prev = new_node
    new_node.next = @tail
  
  end

  def update(key, val)
    self.each do |link|
      if link.key == key
        link.val = val
      end
    end
  end

  def remove(key)
    current = nil
      self.each do |link|
        if key == link.key
          current = link
        end
      end
      
    previous_node = current.prev
    next_node = current.next
    previous_node.next = next_node
    next_node.prev = previous_node
  end

  def each(&prc)
    current_node = first
    while current_node.next != nil
      prc.call(current_node)
      current_node = current_node.next
    end
  end





  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
