#!/bin/bash

# Fetch stock price information using Yahoo Finance API
# Usage: ./get_stock_price.sh [stock_symbol]
# Example: ./get_stock_price.sh AAPL

usage() {
    echo "Usage: $0 STOCK_SYMBOL"
    echo "  STOCK_SYMBOL: Stock ticker symbol (e.g., AAPL, GOOGL, MSFT)"
    echo ""
    echo "Examples:"
    echo "  $0 AAPL      # Get Apple stock price"
    echo "  $0 GOOGL     # Get Google stock price"
    echo "  $0 MSFT      # Get Microsoft stock price"
    echo ""
    echo "Note: This script uses Yahoo Finance API. Please ensure you have"
    echo "      internet connectivity and the API is accessible."
    exit 1
}

# Show usage if --help or -h is passed or no arguments
if [ "$1" = "--help" ] || [ "$1" = "-h" ] || [ "$#" -eq 0 ]; then
    usage
fi

# Validate argument count
if [ "$#" -ne 1 ]; then
    echo "Error: Expected exactly 1 argument, got $#"
    usage
fi

SYMBOL=$(echo "$1" | tr '[:lower:]' '[:upper:]')

# Validate stock symbol format (basic check)
if ! [[ "$SYMBOL" =~ ^[A-Z]{1,5}$ ]]; then
    echo "Warning: '$SYMBOL' may not be a valid stock symbol"
    echo "Stock symbols are typically 1-5 uppercase letters"
fi

echo "Fetching stock price for $SYMBOL..."
echo ""

# Using Yahoo Finance Query API (v7)
# This endpoint is more stable than the legacy CSV endpoint
RESPONSE=$(curl -s --fail --connect-timeout 10 \
    "https://query1.finance.yahoo.com/v8/finance/chart/${SYMBOL}?interval=1d&range=1d")

# Check if curl was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to fetch data from Yahoo Finance API"
    echo "Please check your internet connection and try again"
    exit 1
fi

# Check if response contains error
if echo "$RESPONSE" | grep -q '"error"'; then
    echo "Error: Invalid stock symbol or API error"
    echo "Please verify the stock symbol is correct"
    exit 1
fi

# Parse the JSON response to extract current price and change
# Using basic shell tools (grep, sed) to avoid dependency on jq
PRICE=$(echo "$RESPONSE" | grep -o '"regularMarketPrice":[^,}]*' | sed 's/"regularMarketPrice"://' | head -1)
CHANGE=$(echo "$RESPONSE" | grep -o '"regularMarketChange":[^,}]*' | sed 's/"regularMarketChange"://' | head -1)
CHANGE_PERCENT=$(echo "$RESPONSE" | grep -o '"regularMarketChangePercent":[^,}]*' | sed 's/"regularMarketChangePercent"://' | head -1)

if [ -z "$PRICE" ]; then
    echo "Error: Could not parse stock price from API response"
    exit 1
fi

echo "Symbol: $SYMBOL"
echo "Current Price: \$$PRICE"
if [ -n "$CHANGE" ]; then
    echo "Change: \$$CHANGE ($CHANGE_PERCENT%)"
fi

