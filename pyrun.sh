#!/bin/bash

# Check if a file is provided
if [ -z "$1" ]; then
  echo "Please provide the file to run."
  exit 1
fi

# Log the start time (formatted as hour:minute:second)
start_time=$(date +"%T")  # This will give you the time in HH:MM:SS format
echo "[Started at $start_time]"
echo ""

# Capture the start time in milliseconds (for execution time calculation)
start=$(date +%s%3N)  # Captures time with millisecond precision

# Run the program (adjust this to use python, dotnet, or other commands you need)
# If the file is Python, you can use the virtualenv python
~/.venv/nvim/bin/python -u "$1"

# Capture the end time in milliseconds
end=$(date +%s%3N)

# Calculate the execution time in milliseconds and divide by 1000 to get seconds
execution_time=$(echo "scale=2; ($end - $start) / 1000" | bc)

# Output the execution time rounded to 2 decimal places
echo ""
echo "[Program executed in ${execution_time}s]"
