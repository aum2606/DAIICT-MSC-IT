#!/bin/bash

# Get current day of the week
current_day=$(date +%A)

echo "Today's Schedule for $current_day:"
echo "=================================="

# Check if timetable.csv exists
if [[ ! -f "timetable.csv" ]]; then
    echo "Error: timetable.csv not found!"
    exit 1
fi

# Filter and display today's schedule
grep "^$current_day," timetable.csv | while IFS=',' read -r day time course instructor room; do
    printf "%-12s %-15s %-10s %-10s %s\n" "$time" "$course" "$instructor" "$room" ""
done | sort -k1

# If no classes found
if [[ $(grep -c "^$current_day," timetable.csv) -eq 0 ]]; then
    echo "No classes scheduled for today!"
fi