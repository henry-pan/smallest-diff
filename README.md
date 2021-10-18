# Smallest Difference

A program that reads from some input files depending on the mode:

- `weather`: returns the day with smallest temperature spread

- `soccer`: returns the team with smallest goal (for/against) difference

# Usage

To run the code, enter in the terminal:

```sh
ruby smallest_difference.rb arg
```

where `arg` is either `weather` or `soccer`.

For example, to run the program to find the weather spread, run:

```sh
ruby smallest_difference.rb weather
```

# Approach

I noticed that the two questions were very similar in nature, so I figured that they would have the same underlying logic. The program would be able to run the same "difference checking" logic on multiple files, which can be handled with modes passed in as an argument. In terms of the logic, it should read the files, get the indices associated with the required columns, and just iterate through the data to find the smallest result.

However, when I looked at at the data files, it was organized in a somewhat inconvenient way, with blank entries or extra headers. This meant I also had to do some parsing logic to make the data readable.

To start, I read the file line-by-line to add them into an array. I only added lines that were longer than 1 to remove blank links or things like `<pre>`.

Each mode is looking for particular columns and requires special data "cleaning", so I checked for a mode using the arguments passed in (ARGV). After setting the mode and reading the file, I clean the array containing the data based on the mode. Weather data has an extra header and asterisks in its columns, soccer data has an extra hyphen and ranking columns. After cleaning, I can get the index of the required columns without mismatching arrays.

To find the smallest difference, I find the columns based on name to avoid hardcoding indices, allowing the program to work even if the columns were moved around. I iterate through the data, keeping track of the last smallest entity and difference, updating when a new smallest is found. The smallest entity is returned after everything is done. This is done in linear time (O(N)).
