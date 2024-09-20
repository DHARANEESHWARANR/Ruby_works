puts "Enter the number :"
num= gets.chomp.to_i

def Fact(num)
	if num<0
		puts "Factorial is not for negative numbers"
	end

	result=1
	(1..num).each do |i|
		result=result*i
	end

	return result
end

puts "The factorial of the number is #{Fact(num)}"


