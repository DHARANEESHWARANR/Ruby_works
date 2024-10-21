require 'date'
require 'benchmark'

csv_file = "large_data_2.csv"

Benchmark.bm do |x|
  # Generate the original CSV file with random dates
  x.report("Creating CSV file:") do
    begin
      File.open(csv_file, "w") do |file|
        file.puts "ID,Date"
        (1..1_000_000).each do |i|
          random_date = Date.today - rand(0..365)
          formatted_date = random_date.strftime("%Y-%m-%d")
          file.puts "#{i},#{formatted_date}"
        end
      end
      puts "CSV file with 1 million rows generated successfully!"
    rescue => e
      puts "An error occurred while creating the CSV file: #{e.message}"
    end
  end

  # Time taken for reading using .foreach
  x.report("Reading with .foreach:") do
    begin
      File.foreach(csv_file).with_index do |line, index|
        id, date = line.strip.split(',')
      end
    rescue => e
      puts "An error occurred while reading the CSV file with foreach: #{e.message}"
    end
  end

  # Time taken for reading using .read
  x.report("Reading with .read:") do
    begin
      data = File.read(csv_file)
      data.each_line do |line|
        id, date = line.strip.split(',')
      end
    rescue => e
      puts "An error occurred while reading the CSV file with read: #{e.message}"
    end
  end

  # Time taken for updating the CSV in place
  x.report("Updating CSV in-place:") do
    updated_lines = []

    begin
      # Read the file line by line and update each row
      File.foreach(csv_file).with_index do |line, index|
        if index == 0
          updated_lines << line  
        else
          id, date = line.strip.split(',')
          if date
            date_object = Date.parse(date)
            formatted_date = date_object.strftime("%b %d")  
            updated_lines << "#{id},#{formatted_date}"
          else
            updated_lines << line.strip  
          end
        end
      end

      File.open(csv_file, "w") do |file|
        updated_lines.each { |line| file.puts(line) }
      end
      puts "The CSV updated successfully in the same file: #{csv_file}!"
    rescue => e
      puts "An error occurred while updating the CSV file: #{e.message}"
    end
  end
end
