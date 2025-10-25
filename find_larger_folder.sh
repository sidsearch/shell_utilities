#!/bin/bash

# Find folders larger than a specified size threshold
# Usage: ./find_larger_folder.sh [size_threshold] [directory]
# Example: ./find_larger_folder.sh 1G /home/user

usage() {
    echo "Usage: $0 [SIZE] [DIRECTORY]"
    echo "  SIZE: Size threshold (e.g., 1G, 500M, 2G) - default: 1G"
    echo "  DIRECTORY: Directory to search - default: current directory"
    echo "Examples:"
    echo "  $0              # Find folders > 1GB in current directory"
    echo "  $0 500M         # Find folders > 500MB in current directory"
    echo "  $0 2G /home     # Find folders > 2GB in /home"
    exit 1
}

# Parse arguments
SIZE_THRESHOLD="${1:-1G}"
SEARCH_DIR="${2:-.}"

# Validate directory exists
if [ ! -d "$SEARCH_DIR" ]; then
    echo "Error: Directory '$SEARCH_DIR' does not exist"
    exit 1
fi

# Validate size format (must end with K, M, or G)
if ! echo "$SIZE_THRESHOLD" | grep -qE '^[0-9]+(\.[0-9]+)?[KMG]$'; then
    echo "Error: Invalid size format '$SIZE_THRESHOLD'"
    echo "Size must be a number followed by K, M, or G (e.g., 1G, 500M, 100K)"
    exit 1
fi

# Extract the unit (K, M, or G)
UNIT="${SIZE_THRESHOLD: -1}"

# Find folders larger than the threshold
echo "Searching for folders larger than $SIZE_THRESHOLD in $SEARCH_DIR..."
du -sh "$SEARCH_DIR"/* 2>/dev/null | grep -E "[0-9]+(\.[0-9]+)?${UNIT}" | sort -hr
