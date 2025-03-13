#!/bin/bash

# Specify the file path
file="$HOME/testing/.config/nvim/lua/custom/plugins.lua"

# Check if the file exists
if [ ! -f "$file" ]; then
  echo "File does not exist. Creating the file..."
  mkdir -p "$(dirname "$file")"  # Create the directory if it doesn't exist
  touch "$file"  # Create the file
  echo "File created successfully at $file."
else
  echo "File already exists at $file."
fi
