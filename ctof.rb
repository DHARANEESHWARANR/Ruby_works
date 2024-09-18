puts "Enter the celcius: "
 
c=gets.chomp.to_f

def fahtocel(c)
	return f= (9/5)*c+32
end

puts "The fahrenheit is #{fahtocel(c)}"


f=gets.chomp.to_f

def celtofah(f)
	return (5/9)*f-32
end
puts "Enter the fahrenheit: "
f=gets.chomp.to_f
puts "The fahrenheit is #{fahtocel(f)}"

