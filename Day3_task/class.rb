class Animal
	def initialize(name,age)
		@name = name
		@age = age
	end

	def description
		puts "The name is #{@name} and the age is #{@age}"
	end
end

lion = Animal.new("Lion",47)

lion.description

