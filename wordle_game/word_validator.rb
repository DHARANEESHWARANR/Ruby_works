require 'httparty'
require 'colorize'
require 'socket'
module WordValidator
  def valid_five_letter_word?(word)
    word.match?(/^[a-zA-Z]+$/) && word_exists?(word)
   end
 
   def word_exists?(word)
    if internet_connected?
      response = HTTParty.get("https://api.dictionaryapi.dev/api/v2/entries/en/#{word}")
      return response.code == 200
    else
      puts "Internet Is Not Connected"
    end
   end
end