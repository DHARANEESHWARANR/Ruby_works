

def bubble_sort(arr)
	loop do 
		swapping = false
    for i in (0...arr.length-1)
      if arr[i]>arr[i+1] 
        arr[i],arr[i+1] = arr[i+1],arr[i]
        swapping = true
      end
    end
    break unless swapping
  end
  arr
end



arr = [10,43,23,45,7,43,2,3]

result_array = bubble_sort(arr)

puts "The Sorted Array is : #{result_array}"