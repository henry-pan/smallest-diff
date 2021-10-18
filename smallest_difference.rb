require_relative "parse.rb"


# Removes non-data elements from input data.
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


def clean_weather_input!(input_arr)
  input_arr.shift
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


input = nil
name = ""
col1 = ""
col2 = ""

modes = {
  "weather" => ["./w_data.dat", "Dy", "MxT", "MnT"],
  "soccer" => ["./soccer.dat", "Team", "F", "A"],
}

if ARGV[0]
  mode = modes[ARGV[0]]
  input = file_to_array(mode[0])
  name = mode[1]
  col1 = mode[2]
  col2 = mode[3]
else
  puts "usage: ruby smallest_difference.rb [weather / soccer]"
  return
end

# Clean up the input before calling main method.
case ARGV[0]
when "weather"
  clean_weather_input!(input)
when "soccer"
  clean_soccer_input!(input)
end

puts smallest_difference(input, name, col1, col2)
