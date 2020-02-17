class HashSet
  attr_reader :count
  attr_accessor :store
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if !include?(key)
      resize! if count == num_buckets
      self[key] << key
      @count += 1
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    store[num.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    copy = @store.dup
    @store = Array.new(num_buckets*2) { Array.new }
    copy.each do |bucket|
      bucket.each do |num|
        self[num] << num
      end
    end
  end
end
