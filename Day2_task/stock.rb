def max_profit(arr)
  max_profit = 0
  i = 0
  min = 0
  for i in (0...arr.length)
    if arr[i] < arr[min]
      min = i
    else
      profit = arr[i] - arr[min]
      if profit > max_profit
        max_profit = profit
      end
    end
  end
    max_profit
end






arr = [17,3,1,6,9,15,8,34]

result= max_profit(arr)

puts "The result is #{result}"