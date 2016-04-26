#!/bin/sh
usage ()
{
  echo 'Usage : ./get_stock_price.sh aapl'
  exit
}

if [ "$#" -ne 1 ]
then
  usage
fi
curl -s "http://download.finance.yahoo.com/d/quotes.csv?s=$1&f=l1c1"

