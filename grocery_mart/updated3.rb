class Main
  @@cash_register = {}           #Hold The Cash Box Denominations
  @@total_amount =0              #Total cash available in cash Box
  @@exchange_denominations = []  #exchange denomination given to the customer
  @@denomination_list_of_store = ["2000rs Notes","500rs Notes","100rs Notes","50rs Notes","20rs Notes","20rs coins","10rs Notes","10rs coins","2rs coins","1rs coins"]
  @@customer_cash_denominations = []  #customer cash denomination
  @@exchange_amount = 0;            #The exchange wants to be given 
  @@check = 0
  @@sorted_hash = {}

  def display_main_menu
    while true
      puts " "
      puts "Enter Your Choice According To The Below Mentioned : "
      puts "Enter 1 ->> To Start the Process and Input the Available Store Denominations "
      puts "Enter 2 ->> To Start The Billing Process And To Get Billing Information From Customers"
      puts "Enter 3 ->> To View Store Denominations and Cash Box Status"
      puts "Enter 4 ->> To View The Total Amount Available In The Cash_Box"
      puts "Enter 5 ->> To Exit From The Process"
      choice = gets.chomp.to_i
      if choice == 1
        @@check =1
        store_denominations_inputting
      elsif choice == 2
        if @@check == 1
          get_billing_info_from_customers
        else
          puts " "
          puts "The Cash Box is Not Loaded , So please for some Time"
        end
      elsif choice == 3 
        display_store_denominations_info(@@cash_register)
      elsif choice == 4 
        display_total_amount_available
      elsif choice == 5
        break
      else
        puts "!Invalid Number Entered"
        puts "Enter Number From 1-5"
      end
    end
  end


  def display_total_amount_available
    puts "The Total Amount Available In The Cash_Box is #{@@total_amount}"
  end


  def store_denominations_inputting
   puts "The Available Denominations In The Cash Box Are : 2000 500 100 50 10 20 2 1"
   @@denomination_list_of_store.each do |str|
    while true
      puts "Enter Number of #{str}:"
      input = gets.chomp
      if input =~ /^\d+$/ && input.to_i >= 0  
        no_of_notes = input.to_i
        @@cash_register[str] = no_of_notes
        @@total_amount += (no_of_notes) * (str.split.first.to_i)
        break  # Exit the loop once valid input is received
      else
        puts "Invalid input! Please enter a non-negative integer value."
      end
    end
   end
  end

    
    #displaying the available denominations
  def display_store_denominations_info(cash_register)
    if cash_register.empty?
      puts "The Cash Box is Empty, No More Data is Available"
      return
    end
    puts "Here The Updated Cash Box Status :"
    puts " "
    cash_register.each do |key, value|
      puts "| #{key.ljust(12)} = #{value.to_s.ljust(4)} |"
    end
    @@total_amount = 0                                          #initialiing total amount
    cash_register.each do |key,value|                           #updating the total amount
      @@total_amount += (key.split.first.to_i)*(value)
    end

  end

    #gettting amount of exchange
  def get_billing_info_from_customers
    while true  
      puts "Enter the Total Amount Of Customer  Bill  : "
      bill_amount = gets.chomp.to_i
      puts " "
      puts "Enter the Amount That Customer Paid: "
      cash_given = gets.chomp.to_i
      #calculate the exchange
      current_exchange = cash_given - bill_amount
      if current_exchange < 0
        puts "! You have Provided Insufficient Money "   ## upadte money
        puts "Give #{current_exchange*-1}rs Or More To Proceed"
      elsif current_exchange == 0
        puts "The Billing Process Completed, Thank You"
        return
      else
        break
      end
    end
    customer_denominations_calculations(cash_given)
    exchange_amount_calculations(current_exchange,cash_given)
  end
    

  def exchange_amount_calculations(exchanges,amount_given)
    @@exchange_amount = exchanges
    @@exchange_denominations = []
    puts " "
    @@sorted_hash = @@cash_register
    if process_exchange_calculation(@@sorted_hash,exchanges)
      return 
    else
      puts "!Sorry Exchange is Not Currently Available"
      puts "Collect Your Cash : #{amount_given}"
      return 
    end 
    @@cash_register = sorted_hash
  end


  def process_exchange_calculation(sorted_hash,exchanges)
    sorted_hash.each do |key,value|
      temp_key = key
      key =  key.split.first.to_i
      subtotal = key * value  
      if subtotal <= exchanges                          #condition_1
        exchanges = exchanges - subtotal                #reduces exchanges amount
        sorted_hash[temp_key] = 0                       #reduces hash value in notes
        @@exchange_denominations << value
        if exchanges == 0
          @@total_amount = @@exchange_amount
          return complete_exchange_and_update
        end
      elsif subtotal > exchanges                       #condition_2
        denominations = (exchanges/key).to_i           # find the denominations
        exchanges = exchanges - (key*denominations)    # reduces the exchanges
        sorted_hash[temp_key] = value - denominations  # update the hash table
        @@exchange_denominations << denominations      #inserting the denominations
        if exchanges == 0 
          @@total_amount = @@exchange_amount
          return complete_exchange_and_update
        end
      end
    end
    return false
  end
    
  def complete_exchange_and_update
    puts "The Billing Process Completed, Thank You"
    puts " "
    get_exchange_denominations_details(@@exchange_denominations)
    return true
  end

  def get_exchange_denominations_details(exchange_denominations)
    puts "The Exchage Wants To Be Given Is : #{@@exchange_amount}"
    puts " "
    puts "Here The Denominations Details About The Exchange Cash Given To The Customers: "
    puts " "

    (0..9).each do |i|
      if exchange_denominations[i]!=0
        puts "|#{@@denomination_list_of_store[i].to_s.ljust(12)}   #{exchange_denominations[i].to_s.ljust(4)}|"
      end
    end
  end

  def customer_denominations_calculations(amount_given)
    index = 0
    @@cash_register.each do |key, value| 
      current_val = key.split.first.to_i
      if current_val > amount_given
        index += 1
      else 
        break
      end
    end 
    puts " "
    ### one more functions
    customer_denominations_inputting(index,amount_given)
    # Update the store based on the provided denominations
    update_cash_register
  end

  
  def update_cash_register
    i = 0
    @@cash_register.each do |key, value|
      value_of_array = @@customer_cash_denominations[i]
      @@cash_register[key] = @@cash_register[key] + value_of_array
      i += 1
    end
  end

  def customer_denominations_inputting(index,amount_given)
    sum = 0
    while sum != amount_given
      @@customer_cash_denominations = Array.new(10, 0)
      sum = 0
      puts "Enter the Denominations Of Cash Given By The Customer For The Billing Process :"
      iterator = 0
      @@denomination_list_of_store.each do |str|
        if iterator < index
          iterator += 1
          next
        end
        puts "Enter no of #{str}: "
        total_notes = gets.chomp.to_i
        @@customer_cash_denominations[iterator] = total_notes
        sum += total_notes * (str.split.first.to_i)
        if sum == amount_given                         # If the sum matches the amount given, break out of the loop.
          puts " "
          puts "Denominations Are Entered Correctly"
          break                                        # Exit the loop immediately when the correct amount is entered.
        elsif sum > amount_given
          puts "Amount Is Exceeding The Cash_Given. Please Enter the Correct Denominations"
          break                                        # Exit to retry input when amount exceeds.
        end
        iterator += 1
      end
   end
  end



 
    

end

obj = Main.new
obj.display_main_menu




## simplify the logic 
## while entereing denominatins -20 invalid 
## also handle the invalid characters 10 1O is diffrent so solve this 
##each method should be counted 5 - 10