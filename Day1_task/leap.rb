puts "Enter the number"

num = gets.chomp.to_i

def leapyear(num)
	if (num%4==0) && (num%100==0 || num%400==0)
		return true
	else 
		return false
	end
end

puts "The result is #{leapyear(num)}"