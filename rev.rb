def rev(str)
  newString=""
  str.each_char do |char|
    newString=char+newString
  end
  newString
end

puts "Enter the String:"
str = gets.chomp

puts "The result is #{str.reverse}"
puts "The result is #{rev(str)}"
