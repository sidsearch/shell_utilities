#!/bin/bash

# Split a CSV file into smaller chunks while preserving headers
# Usage: ./split_smaller.sh [input_file] [lines_per_file] [output_prefix]
# Example: ./split_smaller.sh data.csv 10000 chunk_

usage() {
    echo "Usage: $0 [INPUT_FILE] [LINES_PER_FILE] [OUTPUT_PREFIX]"
    echo "  INPUT_FILE: CSV file to split (default: train.csv)"
    echo "  LINES_PER_FILE: Number of lines per output file (default: 20000)"
    echo "  OUTPUT_PREFIX: Prefix for output files (default: split_)"
    echo ""
    echo "Examples:"
    echo "  $0                            # Split train.csv into 20k line chunks"
    echo "  $0 data.csv 10000             # Split data.csv into 10k line chunks"
    echo "  $0 data.csv 5000 chunk_       # Split data.csv into 5k line chunks named chunk_*"
    exit 1
}

# Show usage if --help or -h is passed
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    usage
fi

# Parse arguments with defaults
INPUT_FILE="${1:-train.csv}"
LINES_PER_FILE="${2:-20000}"
OUTPUT_PREFIX="${3:-split_}"

# Validate input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' does not exist"
    exit 1
fi

# Validate input file is not empty
if [ ! -s "$INPUT_FILE" ]; then
    echo "Error: Input file '$INPUT_FILE' is empty"
    exit 1
fi

# Validate LINES_PER_FILE is a positive integer
if ! [[ "$LINES_PER_FILE" =~ ^[0-9]+$ ]] || [ "$LINES_PER_FILE" -le 0 ]; then
    echo "Error: LINES_PER_FILE must be a positive integer, got: $LINES_PER_FILE"
    exit 1
fi

echo "Splitting '$INPUT_FILE' into chunks of $LINES_PER_FILE lines with prefix '$OUTPUT_PREFIX'..."

# Split the file (excluding header)
tail -n +2 "$INPUT_FILE" | split -l "$LINES_PER_FILE" - "$OUTPUT_PREFIX"

# Check if split was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to split file"
    exit 1
fi

# Add header to each split file
HEADER=$(head -n 1 "$INPUT_FILE")
COUNT=0
for file in ${OUTPUT_PREFIX}*; do
    # Skip if no files were created
    if [ ! -f "$file" ]; then
        continue
    fi

    # Create temporary file with header
    echo "$HEADER" > "${file}.tmp"
    cat "$file" >> "${file}.tmp"
    mv -f "${file}.tmp" "$file"
    COUNT=$((COUNT + 1))
done

echo "Successfully created $COUNT split files"
