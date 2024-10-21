require 'date'
require 'csv'
require 'benchmark'

csv_file = "large_data_1.csv"

Benchmark.bm do |x|
  # Step 1: Generate the original CSV file with random dates
  x.report("Creating CSV file:") do
    CSV.open(csv_file, "w") do |csv|
      csv << ["ID", "Date"]  # Write headers
      (1..5_000_000).each do |i|
        random_date = Date.today - rand(0..365)
        formatted_date = random_date.strftime("%Y-%m-%d")
        csv << [i, formatted_date]
      end
    end
  end
  puts "CSV file with 5 million rows generated successfully!"

  # Step 2: Time taken for reading using CSV.foreach
  x.report("Reading with CSV.foreach:") do
    CSV.foreach(csv_file, headers: true) do |row|
      id = row["ID"]
      date = row["Date"]
      # Process id and date as needed
    end
  end

  # Step 3: Time taken for reading using CSV.read
  x.report("Reading with CSV.read:") do
    begin
      data = CSV.read(csv_file, headers: true)
      data.each do |row|
        id = row["ID"]
        date = row["Date"]
        # Process id and date as needed
      end
    rescue => e
      puts "An error occurred: #{e.message}"
    end
  end

  # Step 4: Time taken for updating the CSV in place
  x.report("Updating CSV in-place:") do
    updated_rows = []

    # Read the CSV file and update each row
    CSV.foreach(csv_file, headers: true) do |row|
      id = row["ID"]
      date = row["Date"]
      if date
        date_object = Date.parse(date)
        formatted_date = date_object.strftime("%b %d")  # Format date as "Oct 21"
        updated_rows << [id, formatted_date]
      else
        updated_rows << [id, date]
      end
    end

    # Write the updated rows back to the CSV file
    CSV.open(csv_file, "w") do |csv|
      csv << ["ID", "Date"]  # Write headers
      updated_rows.each do |row|
        csv << row
      end
    end
  end
  puts "CSV updated successfully!"
end
