#!/bin/bash

# Display the most frequently used shell commands from history
# Usage: ./list_of_frequent_commands.sh [count]
# Example: ./list_of_frequent_commands.sh 20

usage() {
    echo "Usage: $0 [COUNT]"
    echo "  COUNT: Number of top commands to display (default: 10)"
    echo ""
    echo "Examples:"
    echo "  $0       # Show top 10 most frequent commands"
    echo "  $0 20    # Show top 20 most frequent commands"
    exit 1
}

# Show usage if --help or -h is passed
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    usage
fi

# Parse arguments with defaults
COUNT="${1:-10}"

# Validate COUNT is a positive integer
if ! [[ "$COUNT" =~ ^[0-9]+$ ]] || [ "$COUNT" -le 0 ]; then
    echo "Error: COUNT must be a positive integer, got: $COUNT"
    exit 1
fi

echo "Top $COUNT most frequently used commands:"
echo "========================================="

# Extract commands from history, count occurrences, and display top N
# Simplified pipeline: extract command name, sort, count, and display top results
history | awk '{print $2}' | awk -F'|' '{print $1}' | sort | uniq -c | sort -rn | head -n "$COUNT"

