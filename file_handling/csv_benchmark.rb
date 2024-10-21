require 'date'
require 'csv'
require 'benchmark'
require 'win32ole'

def enough_memory?(wanted_memory)
    wmi = WIN32OLE.connect('winmgmts://.')
    memory_info = wmi.ExecQuery('SELECT FreePhysicalMemory FROM Win32_OperatingSystem')
  
    memory_info.each do |mem|
      free_memory_kb = mem.FreePhysicalMemory.to_i
      free_memory_mb = free_memory_kb / 1024.0
      puts "\nThe Total Space available in RAM : #{free_memory_mb} mb"
      puts "The Total Space Needed For Process : #{wanted_memory} mb"
      return free_memory_mb > wanted_memory
    end
end

csv_file = "large_data_3.csv"

Benchmark.bm do |x|
  # Step 1: Generate the original CSV file with random dates
  no_of_data_in_millions = 1_000_000
  #memory calculations
  total_bytes = no_of_data_in_millions * (18)
  total_bytes_in_mb = total_bytes / (1024 * 1024)
  x.report("\nCreating CSV file:") do
    if enough_memory?(total_bytes_in_mb) 
      CSV.open(csv_file, "w") do |csv|
        csv << ["ID", "Date"]  
        (1..no_of_data_in_millions).each do |i|
          random_date = Date.today - rand(0..365)
          formatted_date = random_date.strftime("%Y-%m-%d")
          csv << [i, formatted_date]
        end
      end
      puts "CSV file with 100 million rows generated successfully!"
    else
      puts "Not enough memory to create the CSV file."
    end
  end

  # Step 2: Time taken for reading using CSV.foreach
  x.report("\nReading with CSV.foreach:\n") do
      begin
        CSV.foreach(csv_file, headers: true) do |row|
          id = row["ID"]
          date = row["Date"]
        end
      rescue => e
        puts "An error occurred during foreach reading: #{e.message}"
      end
  end

  # Step 3: Time taken for reading using CSV.read
  x.report("\nReading with CSV.read:") do
    if enough_memory?(total_bytes_in_mb) 
      begin
        data = CSV.read(csv_file, headers: true)
        data.each do |row|
          id = row["ID"]
          date = row["Date"]
         
        end
      rescue => e
        puts "An error occurred during read: #{e.message}"
      end
    else
      puts "Not enough memory to read the CSV file."
    end
  end

  # Step 4: Time taken for updating the CSV in place
  x.report("\nUpdating CSV in-place:") do
    updated_rows = []
    if enough_memory?(total_bytes_in_mb)
      begin
        CSV.foreach(csv_file, headers: true) do |row|
          id = row["ID"]
          date = row["Date"]
          if date
            date_object = Date.parse(date)
            formatted_date = date_object.strftime("%b %d")  
            updated_rows << [id, formatted_date]
          else
            updated_rows << [id, date]
          end
        end

        CSV.open(csv_file, "w") do |csv|
          csv << ["ID", "Date"]  
          updated_rows.each do |row|
            csv << row
          end
        end
        puts "CSV updated successfully!"
      rescue => e
        puts "An error occurred during update: #{e.message}"
      end
    else
      puts "Not enough memory to update the CSV file."
    end
  end
end

