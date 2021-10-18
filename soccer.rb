require_relative "parse"

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


def smallest_difference_of_goals(input_arr)
  # Find the index for the required data, no matter the column.
  team_index = input_arr[0].index("Team")
  for_index = input_arr[0].index("F")
  against_index = input_arr[0].index("A")

  result_team = ""
  smallest_diff = Float::INFINITY

  input_arr.each_with_index do |team, i|
    next if i == 0 # Skip table header

    diff = (team[for_index].to_i - team[against_index].to_i).abs
    if smallest_diff > diff
      smallest_diff = diff
      result_team = team[team_index]
    end
  end

  result_team
end


input = file_to_array("./soccer.dat")
clean_soccer_input!(input)
puts smallest_difference_of_goals(input)
