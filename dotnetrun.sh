#!/bin/bash

# Log the start time (formatted as hour:minute:second)
start_time=$(date +"%T")  # This will give you the time in HH:MM:SS format
echo "[Started at $start_time]"
echo ""

# Capture the start time in milliseconds (for execution time calculation)
start=$(date +%s%3N)  # Captures time with millisecond precision

# run
dotnet run

# Capture the end time in milliseconds
end=$(date +%s%3N)

# Calculate the execution time in milliseconds and divide by 1000 to get seconds
execution_time=$(echo "scale=2; ($end - $start) / 1000" | bc)

# Output the execution time rounded to 2 decimal places
echo ""
echo "[Program executed in ${execution_time}s]"
