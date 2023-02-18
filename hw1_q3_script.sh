#!/bin/sh
cd 01-ps-arnold-jang-problem3
for i in {1..50}; do touch file-$i.txt; done
for i in {1..50}; do sed -n "${i}p" adult.data.txt >> file-${i}.txt; done
find . -depth -name '*-*' -execdir sh -c 'mv "$1" "$(echo "$1" | sed s/-/_/g)"' _ {} \;
find -depth -name '*-*' -execdir sh -c 'mv "$1" "$(echo "$1" | tr "-" "_")"' _ {} \;
cut -d ',' -f 10 new_data_set.csv | grep -c -i "Male" > output.txt
cut -d ',' -f 7 new_data_set.csv | sort -u | awk 'END {print NR}' >> output.txt
find . -type f ! -name 'output.txt' ! -name 'adult.data.txt' -delete

