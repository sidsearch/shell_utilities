#!/bin/bash

# Generate a random number within a specified range
# Usage: ./generate_random_number.sh [min] [max]
# Example: ./generate_random_number.sh 1 100

usage() {
    echo "Usage: $0 [MIN] [MAX]"
    echo "  MIN: Minimum value (default: 1)"
    echo "  MAX: Maximum value (default: 100)"
    echo "Examples:"
    echo "  $0           # Generate random number between 1 and 100"
    echo "  $0 5 10      # Generate random number between 5 and 10"
    echo "  $0 0 1       # Generate random number between 0 and 1 (coin flip)"
    exit 1
}

# Show usage if --help or -h is passed
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    usage
fi

# Parse arguments with defaults
MIN="${1:-1}"
MAX="${2:-100}"

# Validate that MIN and MAX are integers
if ! [[ "$MIN" =~ ^-?[0-9]+$ ]]; then
    echo "Error: MIN must be an integer, got: $MIN"
    exit 1
fi

if ! [[ "$MAX" =~ ^-?[0-9]+$ ]]; then
    echo "Error: MAX must be an integer, got: $MAX"
    exit 1
fi

# Validate that MIN <= MAX
if [ "$MIN" -gt "$MAX" ]; then
    echo "Error: MIN ($MIN) must be less than or equal to MAX ($MAX)"
    exit 1
fi

# Generate and print random number
awk -v min="$MIN" -v max="$MAX" 'BEGIN{srand(); print int(min+rand()*(max-min+1))}'

