awk -v min=5 -v max=10 'BEGIN{srand(); print int(min+rand()*(max-min+1))}'

