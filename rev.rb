puts "Enter the String:"
abc=gets.chomp
def rev_b(str)
	return str.reverse
end

def rev(str)
	newString=""
	str.each_char do |char|
		newString=char+newString
	end
	newString
end

puts "The result is #{rev_b(abc)}"

puts "The result is #{rev(abc)}"