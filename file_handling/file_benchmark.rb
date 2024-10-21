require 'date'
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
  # Memory calculations
  total_bytes = no_of_data_in_millions * (18)
  total_bytes_in_mb = total_bytes / (1024 * 1024)

  x.report("Creating CSV file:") do
    if enough_memory?(total_bytes_in_mb)
      File.open(csv_file, "w") do |file|
        file.puts "ID,Date"  
        (1..no_of_data_in_millions).each do |i|
          random_date = Date.today - rand(0..365)
          formatted_date = random_date.strftime("%Y-%m-%d")
          file.puts "#{i},#{formatted_date}" 
        end
      end
      puts "CSV file with 1 million rows generated successfully!"
    else
      puts "Not enough memory to create the CSV file."
    end
  end

  # Step 2: Time taken for reading using File.foreach
  x.report("Reading with File.foreach:\n") do
    begin
      File.foreach(csv_file).with_index do |line, index|
        next if index == 0  
        id, date = line.strip.split(",")
      end
    rescue => e
      puts "An error occurred during foreach reading: #{e.message}"
    end
  end

  # Step 3: Time taken for reading using File.read
  x.report("Reading with File.read:") do
    if enough_memory?(total_bytes_in_mb)
      begin
        data = File.read(csv_file).lines
        data.each_with_index do |line, index|
          next if index == 0 
          id, date = line.strip.split(",")
        end
      rescue => e
        puts "An error occurred during read: #{e.message}"
      end
    else
      puts "Not enough memory to read the CSV file."
    end
  end

  # Step 4: Time taken for updating the CSV in place
  x.report("Updating CSV in-place:") do
    updated_rows = []
    if enough_memory?(total_bytes_in_mb)
      begin
        File.foreach(csv_file).with_index do |line, index|
          next if index == 0 
          id, date = line.strip.split(",")
          if date
            date_object = Date.parse(date)
            formatted_date = date_object.strftime("%b %d")
            updated_rows << "#{id},#{formatted_date}" 
          else
            updated_rows << "#{id},#{date}"
          end
        end

        File.open(csv_file, "w") do |file|
          file.puts "ID,Date"  
          updated_rows.each do |row|
            file.puts row  
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
