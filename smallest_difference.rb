def file_to_array(filepath)
  array = []

  File.foreach(filepath) do |line|
    # Clean up the line, then split on space.
    current_line = line.chomp
    current_entry = current_line.split

    # Add to the input array only if it contains data.
    array << current_entry if current_entry.length > 1
  end

  array
end


def clean_weather_input!(input_arr)
  # Remove date header.
  input_arr.shift

  (1...input_arr.length).each do |i|
    entry = input_arr[i]

    # Remove any asterisks.
    entry.map { |value| value.chomp!("*") }

    input_arr[i] = entry
  end
  
  input_arr
end


def clean_soccer_input!(input_arr)
  (1...input_arr.length).each do |i|
    # Remove ranking index.
    entry = input_arr[i].drop(1)

    # Remove the hyphen between F and A.
    entry.select! { |value| value != "-" }

    input_arr[i] = entry
  end

  input_arr
end


def smallest_difference(input_arr, name, col1, col2)
  # Find the index for the required data, no matter the column.
  name_index = input_arr[0].index(name)
  col1_index = input_arr[0].index(col1)
  col2_index = input_arr[0].index(col2)

  result_name = 0
  smallest_diff = Float::INFINITY

  input_arr.each_with_index do |row, i|
    next if i == 0 # Skip table header

    diff = (row[col1_index].to_i - row[col2_index].to_i).abs
    if smallest_diff > diff
      smallest_diff = diff
      result_name = row[name_index]
    end
  end

  result_name
end


if !ARGV[0]
  puts "usage: ruby smallest_difference.rb [weather / soccer]"
  return
end

# Initialize and assign mode variables depending on ARGV.
modes = {
  "weather" => ["./w_data.dat", "Dy", "MxT", "MnT"],
  "soccer" => ["./soccer.dat", "Team", "F", "A"],
}
mode = modes[ARGV[0]]
input = file_to_array(mode[0])

# Clean up the input before calling main method.
case ARGV[0]
when "weather"
  clean_weather_input!(input)
when "soccer"
  clean_soccer_input!(input)
end

puts smallest_difference(input, mode[1], mode[2], mode[3])
