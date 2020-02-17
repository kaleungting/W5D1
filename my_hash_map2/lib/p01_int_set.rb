class MaxIntSet
  
  attr_accessor :store

  def initialize(max)
    @store = Array.new(max, false)

  end

  def insert(num)
    if is_valid?(num)
      self[num] = true
    end
    store
  end

  def []=(num, val)
    store[num] = val
  end

  def remove(num)
    if is_valid?(num)
      self[num] = false
    end
    store
  end

  def include?(num)
    store[num]
  end

  private


  def is_valid?(num)
    if !(0...@store.length).include?(num)
      raise "Out of bounds"
    end
      true
  end

  def validate!(num)
  end
end


class IntSet

  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    store[num%num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count
  attr_accessor :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !include?(num)
      resize! if count == num_buckets
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    store[num%num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
      copy = @store.dup
      @store = Array.new(num_buckets*2)  { Array.new }
      copy.each do |bucket|
        bucket.each do |num|
          self[num] << num
        end
      end
  end




end
