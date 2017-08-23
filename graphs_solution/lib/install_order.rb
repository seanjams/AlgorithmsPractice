def install_order2(arr)
  queue = []
  counts = Hash.new(0)

  arr.each do |el|
    counts[el[0]] += 1
    queue << el if el[1].nil?
  end

  result = []

  until queue.empty?
    current = queue.shift[0]
    result << current
    counts[current] -= 1
    arr.each do |el|
      if result.include?(el[1])
        result << el[0]
      end
    end

  end



end
