require 'byebug'

class Fixnum
  # Fixnum#hash already implemented for you
end

ALPHA = ("a".."z").to_a

class Array
  def hash
    num_str = []
    self.each_with_index do |el, i|
      num_str << "#{i}#{el.hash.abs}"
    end
    num_str.join("").to_i.hash
  end
end

class String
  def hash
    num_str = []
    self.each_char.with_index do |ch, i|
      num_str << "#{i}#{ALPHA.index(ch)}"
    end
    num_str.join("0").to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_arr = self.sort_by {|k,v| k}.to_a
    result = []
    hash_arr.each do |pair|
      result << pair.hash.abs.to_s
    end
    result.join("").to_i.hash
  end
end
