require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hash = HashMap.new
  string.chars.each do |ch|
    if hash[ch]
      hash[ch] += 1
    else
      hash[ch] = 0
    end
  end
  hash.all? {|k,v| v % 2 == 0}
end
