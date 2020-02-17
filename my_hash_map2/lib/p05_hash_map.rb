require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).each do |link|
      if link.key == key
        return true
      end
    end
    false
  end

  def set(key, val)
    if include?(key)
      bucket(key).update(key, val)
    else
      resize! if @count == num_buckets
      bucket(key).append(key, val)
      @count += 1
    end
  end

  def get(key)
    bucket(key).each do |link|
      if link.key == key
        return link.val
      end
    end
    nil
  end

  def delete(key)
     if include?(key)
      bucket(key).remove(key)
      @count -= 1
    end
  end

  def each(&prc)
    store.each do |bucket|
      bucket.each do |link|
        prc.call(link.key, link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    copy = @store.dup
    @store = Array.new(num_buckets*2) { LinkedList.new }
    copy.each do |bucket|
      bucket.each do |link|
        bucket(link.key).append(link.key, link.val)
      end
    end
  end

  def bucket(key)
    store[key.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `key`
  end
end
