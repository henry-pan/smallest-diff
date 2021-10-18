require_relative "parse"

# Removes non-data elements from input data, and adds to blank columns.
# def clean_weather_input!(input_arr)
#   # These columns may have blank entries - they need to be filled in.
#   hddday_index = input_arr[1].index("HDDay")
#   1hrp_index = input_arr[1].index("1HrP")
#   wxtype_index = input_arr[1].index("WxType")


#   (2...input_arr.length).each do |i|
#     entry = input_arr[i]

#     # Remove the hyphen between F and A.
#     entry.select! { |value| value != "-" }


#     input_arr[i] = entry
#   end

#   input_arr
# end

def smallest_difference_of_temp(input_arr)
  # Find the index for the required data, no matter the column.
  day_index = input_arr[1].index("Dy")
  max_index = input_arr[1].index("MxT")
  min_index = input_arr[1].index("MnT")

  result_day = 0
  smallest_diff = Float::INFINITY

  input_arr.each_with_index do |day, i|
    next if i <= 1 # Skip table headers

    diff = (day[max_index].to_i - day[min_index].to_i).abs
    if smallest_diff > diff
      smallest_diff = diff
      result_day = day[day_index]
    end
  end

  result_day
end


input = file_to_array("./w_data.dat")
puts smallest_difference_of_temp(input)
