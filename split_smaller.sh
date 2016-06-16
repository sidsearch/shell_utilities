tail -n +2 train.csv | split -l 20,000 - split_
for file in split_*
do
    head -n 1 train.csv > tmp_file
    cat $file >> tmp_file
    mv -f tmp_file $file
done
