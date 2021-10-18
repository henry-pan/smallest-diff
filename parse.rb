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
