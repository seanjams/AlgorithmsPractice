def single_in_sorted(arr)
  return arr[0] if arr.length <= 2
  mid = arr.length / 2
  if arr[mid] == arr[mid - 1]
    single_in_sorted(arr[0..mid])
  elsif arr[mid] == arr[mid + 1]
    single_in_sorted(arr[mid..-1])
  else
    return arr[mid]
  end
end
