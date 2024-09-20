

# without parameter


# def greet
#   puts "Welcome Dharaneeshwaran R"

#   yield if block_given?

#   puts "Hello Asvin"
# end
 
# greet do 
#   puts "Hello this is block" 
# end
 


def greet(name)
  puts "Hello #{name}"

  if block_given?
    #yield("Asvin")
  end

  puts "function completed"
end


greet("Dharaneesh") do |name|
  puts "Hwllo this is #{name}"
end


 