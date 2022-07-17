#!/bin/bash
FILENAME=vehicle_challenge.csv
FILEPATH=/Users/navyasatish/Downloads

#record count check
record_count=`wc -l <$FILEPATH/$FILENAME`
record_count=`expr $record_count - 1`

echo $record_count

#Headers available
header=`head -1 $FILEPATH/$FILENAME`
echo $header

#column count
column_count=`awk -F',' '{print NF; exit}' $FILEPATH/$FILENAME`
echo "Total no of columns is " "$column_count"
