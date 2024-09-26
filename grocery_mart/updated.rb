class Main
  @@cash_register = {}  #Hold The Cash Box Denominations
  @@total_amount =0     #Total cash available in cash Box
  @@exchange_denominations = []  #exchange denomination given to the customer
  @@denomination_list_of_store = ["2000rs Notes","500rs Notes","100rs Notes","50rs Notes","20rs Notes","20rs coins","10rs Notes","10rs coins","2rs coins","1rs coins"]
  @@customer_cash_denominations = []  #customer cash denomination
  @@exchange_amount = 0;            #The exchange wants to be given 
  @@check = 0
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
    puts "The Available Dominations In The Cash Box Are : 2000 500 100 50 10 20 2 1"
    #iterating and Storing the values
    @@denomination_list_of_store.each do |str|
      puts "Enter Number of #{str}"
      #getting no of coins
      no_of_notes = gets.chomp.to_i
      @@cash_register[str] = no_of_notes
      @@total_amount += (no_of_notes)*(str.split.first.to_i)
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

      #initialiing total amount
      @@total_amount = 0
      #updating the total amount
      cash_register.each do |key,value|
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
    

    # #calculating for validation
    # def updated_info(current_exchange,cash_given)
    #   @@exchange_amount = current_exchange
    #   puts " "
    #   ## code to main logic
    #   if @@total_amount < current_exchange
    #     puts "There is no more exchange"
    #     puts " "
    #     return
    #   end
    #     customer_denominations_calculations(cash_given)
    #     exchange_amount_calculations(current_exchange,cash_given)
    # end

    def exchange_amount_calculations(exchanges,amount_given)
      @@exchange_amount = exchanges
      @@exchange_denominations = []
      temp_exchange = exchanges
      puts " "
      sorted_hash = @@cash_register
      sorted_hash.each do |key,value|
        temp_key = key
        key =  key.split.first.to_i
        subtotal = key * value

        #condition_1
        if subtotal <= exchanges
          #reduces exchanges amount
          exchanges = exchanges - subtotal
          #reduces hash value in notes
          sorted_hash[temp_key] = 0

          @@exchange_denominations << value

          #main_logic
          if exchanges == 0
            puts "The Billing Process Completed, Thank You"
            puts " "
            get_exchange_denominations_details(@@exchange_denominations)
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
          @@exchange_denominations << denominations

          if exchanges == 0 
            puts " "
            puts "The  Billing Process Completed, Thank You"
            puts " "
            get_exchange_denominations_details(@@exchange_denominations)
            return
          end
        end
      end
      if  exchanges !=0
        puts "!Sorry Exchange is Not Currently Available"
        puts "Collect Your Cash : #{amount_given}"
        return 
      end 
      @@cash_register = sorted_hash
    end

    def get_exchange_denominations_details(exchange_denominations)
      puts "The Exchage Wants To Be Given Is : #{@@exchange_amount}"
      puts " "
      puts "Here The Denominations Details About The Exchange Cash Given To The Customers: "
      puts " "
      one_rs_denominations_count = 0
      two_rs_denominations_count = 0

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

      # If the sum matches the amount given, break out of the loop.
        if sum == amount_given
          puts " "
          puts "Denominations Are Entered Correctly"
          puts " "
          #update the total amount
          break  # Exit the loop immediately when the correct amount is entered.
        elsif sum > amount_given
          puts "Amount Is Exceeding The Cash_Given. Please Enter the Correct Denominations"
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
    @@cash_register.each do |key, value|
      value_of_array = @@customer_cash_denominations[i]
      @@cash_register[key] = @@cash_register[key] + value_of_array
      i += 1
    end
  end

 
    

end

obj = Main.new
obj.display_main_menu


