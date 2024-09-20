

def multi_pass(block1,block2)
	block1.call
	block2.call
end

block1 = Proc.new{ puts "this is block 1"}

block2= Proc.new{puts "this is block 2"}

puts "this is new to me"

multi_pass(block1,block2)