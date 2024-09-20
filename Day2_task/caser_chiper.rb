def caser(str)
  result = ""
  str.each_char do |ch|
    if ch.match(/[a-z]/)  
      a = ((ch.ord - 'a'.ord + 5) % 26) + 'a'.ord
      result += a.chr
    elsif ch.match(/[A-Z]/)  
      a = ((ch.ord - 'A'.ord + 5) % 26) + 'A'.ord
      result += a.chr
    else
      result += ch 
    end 
  end
  return result 
end

puts "Enter the String:"
word = gets.chomp

final_result = caser(word)  

puts final_result 
