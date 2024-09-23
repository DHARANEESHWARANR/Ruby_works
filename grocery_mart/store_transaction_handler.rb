class Main
  @@notes_count = 0
  @@store = {}
  @@total_amount =0
  @@denomination_used = []
  @@store_array = ["2000rs Notes","500rs Notes","100rs Notes","50rs Notes","20rs Notes","20rs coins","10rs Notes","10rs coins","2rs coins","1rs coins"]
  @@customer_denominations = []

  def switch_functions
    while true
      puts " "
      puts "Enter Your Choice According To The Mentiones : "
      puts "Enter 1 ->> Start the Process "
      puts "Enter 2 ->> Get_info From Customers and Workings"
      puts "Enter 3 ->> To Display The Store Details"
      puts "Enter 4 ->> To exit From The Process"
      choice = gets.chomp.to_i
      if choice == 1
        get_info
      elsif choice == 2
        get_info_from_users
      elsif choice ==3
        display_info(@@store)
      elsif choice ==4
        break
      end
    end
  end

  def get_info
    puts "The Available Dominations Are: 10rs   20rs  50rs 100rs 500rs 2000rs"
    #iterating and Storing the values
    @@store_array.each do |str|
      puts "Enter No of #{str}"
      #getting no of coins
      amounts = gets.chomp.to_i
      @@store[str] = amounts
      @@total_amount += (amounts)*(str.split.first.to_i)
    end

    end
    
    #displaying the available denominations
    def display_info(store)
      puts "The available denominations are: "
      puts " "
      store.each do |key, value|
        puts "| #{key.ljust(12)} = #{value.to_s.ljust(4)} |"
      end
    end

    #gettting amount of exchange
    def get_info_from_users
      puts "Enter the Total_Amount Of Bill  : "
      amount_paid = gets.chomp.to_i
      puts " "
      puts "Enter the Amount given By customers : "
      amount_given = gets.chomp.to_i
      #calculate the exchange
      exchange = amount_given - amount_paid

      updated_info(exchange,amount_given)

    end
    

    #calculating for validation
    def updated_info(exchange,amount_given)
      puts "The values wants to be exchange is : #{exchange}"
      puts " "
      ## code to main logic
      if @@total_amount+6 < exchange
        puts "There is no more exchange"
        puts " "
        return
      end
        customer_denominations_calculations(amount_given)
        update_main(exchange)
    end

    def update_main(exchanges)
      temp_exchange = exchanges
      puts "The Available amount  is #{@@total_amount}"
      puts " "
      sorted_hash = @@store
      sorted_hash.each do |key,value|
        temp_key = key
        key =  key.split.first.to_i
        @@notes_count+=1
        subtotal = key * value

        #condition_1
        if subtotal <= exchanges
          #reduces exchanges amount
          exchanges = exchanges - subtotal
          #reduces hash value in notes
          sorted_hash[temp_key] = 0

          @@denomination_used << value

          #main_logic

          if @@notes_count == 10 and exchanges!=0
            puts "The remaining amount is #{exchanges}"
            puts " "
            puts "Collect Chocolates for #{exchanges}rs"
            exchanges = 0

          end
          if exchanges == 0
            puts "Process Completed"
            puts " "
            transaction_details(@@denomination_used)
    
           
            return 
          end

        #condition_2
        elsif subtotal > exchanges
          # find the denominations
          denominations = (exchanges/key).to_i
          # reduces the exchanges
          exchanges = exchanges - (key*denominations)
          # update the hash table
          sorted_hash[temp_key] = value - denominations

          #inserting the denominations
          @@denomination_used << denominations
          if @@notes_count == 10 and exchanges !=0
            puts "There is No denominations"
            return 
          end
          if @@notes_count == 10 and exchanges!=0
            puts "the remaining is #{exchanges}"
            puts " "
            puts "Collect Chocolates for #{exchanges}rs"
            exchanges = 0
          end
          if exchanges == 0 
            puts " "
            puts "Process Completed"
            puts " "
            transaction_details(@@denomination_used)
            
            return
          end
        end
      end
      @@store = sorted_hash

    end

    def transaction_details(arr)
      puts " "
      puts "The Return Denominations Given To The Customer : "
      puts " "
      (0..9).each do |i|
        if arr[i]!=0
          puts "|#{@@store_array[i].to_s.ljust(12)}   #{arr[i].to_s.ljust(4)}|"
        end
      end
    end

   def customer_denominations_calculations(amount_given)
  index = 0
  @@store.each do |key, value| 
    current_val = key.split.first.to_i
    if current_val > amount_given
      index += 1
    else 
      break
    end
  end 
  puts " "
  
  sum = 0
  while sum != amount_given
    @@customer_denominations = Array.new(10, 0)
    sum = 0
    puts "Enter the denominations for respectives Notes or Coins"
    iterator = 0
    
    @@store_array.each do |str|
      if iterator < index
        iterator += 1
        next
      end

      puts "Enter no of #{str}: "
      total_notes = gets.chomp.to_i
      @@customer_denominations[iterator] = total_notes
      sum += total_notes * (str.split.first.to_i)

      # If the sum matches the amount given, break out of the loop.
      if sum == amount_given
        puts "Correct Denominations Entered"
        puts " "
        break  # Exit the loop immediately when the correct amount is entered.
      elsif sum > amount_given
        puts "Amount is exceeding. Please Enter the Correct Denominations"
        break  # Exit to retry input when amount exceeds.
      end

      iterator += 1
    end

    if sum == amount_given
      break  # Exit the outer while loop when the correct sum is entered.
    end
  end

  # Update the store based on the provided denominations
  i = 0
  @@store.each do |key, value|
    value = @@customer_denominations[i]
    @@store[key] = @@store[key] + value
    i += 1
  end
end


    

end

obj = Main.new
obj.switch_functions