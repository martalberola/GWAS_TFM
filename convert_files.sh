#!/bin/bash

# Function to convert files with "AUTO" in their name from a given input directory
convert_files() {
  local INPUT_DIR=$1
  local OUTPUT_DIR=$2

# Create output directory if it doesn't exist
  mkdir -p "$OUTPUT_DIR"

  # Find files containing "AUTO" in their name in the input directory
  for file in "$INPUT_DIR"/*.gz; do
    if [[ -f "$file" ]]; then
      # Determine the output file name
      output_file="$OUTPUT_DIR/$(basename "${file%}_converted.csv.gz")"

      # Decompress, convert delimiters to tabs, and recompress
      zcat "$file" | tr -s ' \t' ',' | gzip -1 > "$output_file"
      echo "Converted: $file -> $output_file"
    fi
  done
  echo "Conversion complete."
}

# Call function with provided arguments
convert_files "$1" "$2"
