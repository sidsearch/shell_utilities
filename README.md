# Shell Utilities

A collection of useful shell scripts for common system administration and data processing tasks.

## Table of Contents

- [Scripts Overview](#scripts-overview)
- [Installation](#installation)
- [Usage](#usage)
- [Script Details](#script-details)
- [Requirements](#requirements)
- [Contributing](#contributing)

## Scripts Overview

| Script | Description | Key Features |
|--------|-------------|--------------|
| `find_larger_folder.sh` | Find folders larger than a specified size | Configurable size threshold, recursive search |
| `generate_random_number.sh` | Generate random numbers within a range | Configurable min/max values |
| `get_stock_price.sh` | Fetch stock prices from Yahoo Finance | Real-time stock data, price changes |
| `list_of_frequent_commands.sh` | Analyze most frequently used shell commands | Configurable result count |
| `split_smaller.sh` | Split CSV files into smaller chunks | Preserves headers, configurable chunk size |

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd shell_utilities
```

2. All scripts are already executable. If needed, you can set permissions manually:
```bash
chmod +x *.sh
```

## Usage

All scripts support `--help` or `-h` flags to display usage information:

```bash
./script_name.sh --help
```

## Script Details

### find_larger_folder.sh

Find folders larger than a specified size threshold.

**Usage:**
```bash
./find_larger_folder.sh [SIZE] [DIRECTORY]
```

**Parameters:**
- `SIZE`: Size threshold (e.g., 1G, 500M, 2G) - default: 1G
- `DIRECTORY`: Directory to search - default: current directory

**Examples:**
```bash
# Find folders > 1GB in current directory
./find_larger_folder.sh

# Find folders > 500MB in current directory
./find_larger_folder.sh 500M

# Find folders > 2GB in /home
./find_larger_folder.sh 2G /home
```

---

### generate_random_number.sh

Generate a random number within a specified range.

**Usage:**
```bash
./generate_random_number.sh [MIN] [MAX]
```

**Parameters:**
- `MIN`: Minimum value (default: 1)
- `MAX`: Maximum value (default: 100)

**Examples:**
```bash
# Generate random number between 1 and 100
./generate_random_number.sh

# Generate random number between 5 and 10
./generate_random_number.sh 5 10

# Generate random number between 0 and 1 (coin flip)
./generate_random_number.sh 0 1
```

---

### get_stock_price.sh

Fetch stock price information using Yahoo Finance API.

**Usage:**
```bash
./get_stock_price.sh STOCK_SYMBOL
```

**Parameters:**
- `STOCK_SYMBOL`: Stock ticker symbol (e.g., AAPL, GOOGL, MSFT)

**Examples:**
```bash
# Get Apple stock price
./get_stock_price.sh AAPL

# Get Google stock price
./get_stock_price.sh GOOGL

# Get Microsoft stock price
./get_stock_price.sh MSFT
```

**Note:** Requires internet connectivity and access to Yahoo Finance API.

---

### list_of_frequent_commands.sh

Display the most frequently used shell commands from history.

**Usage:**
```bash
./list_of_frequent_commands.sh [COUNT]
```

**Parameters:**
- `COUNT`: Number of top commands to display (default: 10)

**Examples:**
```bash
# Show top 10 most frequent commands
./list_of_frequent_commands.sh

# Show top 20 most frequent commands
./list_of_frequent_commands.sh 20
```

---

### split_smaller.sh

Split a CSV file into smaller chunks while preserving headers.

**Usage:**
```bash
./split_smaller.sh [INPUT_FILE] [LINES_PER_FILE] [OUTPUT_PREFIX]
```

**Parameters:**
- `INPUT_FILE`: CSV file to split (default: train.csv)
- `LINES_PER_FILE`: Number of lines per output file (default: 20000)
- `OUTPUT_PREFIX`: Prefix for output files (default: split_)

**Examples:**
```bash
# Split train.csv into 20k line chunks
./split_smaller.sh

# Split data.csv into 10k line chunks
./split_smaller.sh data.csv 10000

# Split data.csv into 5k line chunks named chunk_*
./split_smaller.sh data.csv 5000 chunk_
```

## Requirements

### System Requirements
- Unix-like operating system (Linux, macOS, BSD)
- Bash shell (version 4.0 or higher recommended)

### Dependencies
- Standard Unix utilities: `awk`, `grep`, `sed`, `sort`, `uniq`, `du`, `split`, `head`, `tail`
- `curl` (for get_stock_price.sh)
- Active shell history (for list_of_frequent_commands.sh)

All dependencies are typically pre-installed on Unix-like systems.

## Features

- **Robust Error Handling**: All scripts include comprehensive input validation and error checking
- **Parameterized**: All scripts accept command-line arguments with sensible defaults
- **Help Documentation**: Every script supports `--help` flag for usage information
- **Portable**: Written in standard Bash for maximum compatibility
- **Safe**: Proper quoting and error handling to prevent common shell scripting pitfalls

## Contributing

Contributions are welcome! Please feel free to submit issues or pull requests.

## Author

Siddharth Biswal (siddnitr1@gmail.com)

## License

This project is open source and available for use and modification.
