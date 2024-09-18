p "Enter num"
num1 = gets.chomp.to_i
num2 = 3
def add(num1,num2)
 num1+num2
end

def sub(num1,num2)
	num1-num2
end

def mul(num1,num2)
	num1*num2
end

def div(num1,num2)
	num1/num2
end

def Expo(num1,num2)
	num1**num2
end

def Mod(num1,num2)
	num1%num2
end

puts "addition #{add(100,200)}"
puts "Subraction #{sub(num1,num2)}"
puts "Multiplication #{mul(num1,num2)}"
puts "Division #{div(num1,num2)}"
puts "Expo #{Expo(num1,num2)}"
puts "Modulo #{Mod(num1,num2)}"