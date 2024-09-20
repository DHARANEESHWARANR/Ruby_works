class Student


   @@no_of_students = 0

   def initialize()
   	@@no_of_students+=1
   end

   def self.no_of_students
   	@@no_of_students
   end



   def display_info
   	puts "Student info: "
   	puts "Name : #{name}"
   	puts "Roll_no : #{roll_no}"
   	puts "Department : #{department}"
   end


end


50.times do |i|
	stu


puts "No of Students : #{Student.no_of_students}"

