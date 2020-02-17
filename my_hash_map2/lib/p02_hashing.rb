class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    alpha = ("a".."z").to_a
    total = 0
    self.each_with_index do |ele, i|
      if ele.is_a?(Integer) 
        total += ele.hash * i.hash
      elsif ele.is_a?(String)
        total += ele.hash
      end
    end
    total
  end
end

class String
  def hash
    alpha = ("a".."z").to_a
    total = 0 
    self.each_char.with_index do |char, i|
      idx = alpha.index(char)
      total += idx.hash * i.hash
    end
    total
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    total = 0
    self.each do |k,v|
      total += k.to_s.hash + v.hash
    end
    total
  end
end
