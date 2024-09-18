puts "Enter the Number:"
num = gets.chomp.to_i

puts "The number is #{num}"

def Prime(num)
	if num==0 || num==1
		puts "Not a prime number"
	end

    count=0
    (1..num).each do |i|
    	if num%i==0
    		count=count+1
    	end
    end

    if count==2
    	puts "The number is Prime number"
    else
    	puts "The number is not Prime"
    end
   end

   Prime(num)