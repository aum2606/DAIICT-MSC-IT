#!/bin/bash

# Check if timetable.csv exists
if [[ ! -f "timetable.csv" ]]; then
    echo "Error: timetable.csv not found!"
    exit 1
fi

echo "Classes count per room per day"
echo "=============================="
echo "Room, Day, Count"

# Create a temporary file to store room-day combinations
temp_file=$(mktemp)

# Extract room and day combinations from the CSV
tail -n +2 timetable.csv | cut -d',' -f1,5 | sort > "$temp_file"

# Count occurrences of each room-day combination
sort "$temp_file" | uniq -c | while read -r count day room; do
    echo "$room, $day, $count"
done | sort -t',' -k1,1 -k2,2

# Clean up temporary file
rm "$temp_file"

echo ""
echo "Summary Statistics:"
echo "=================="

# Total classes per room
echo "Total classes per room:"
tail -n +2 timetable.csv | cut -d',' -f5 | sort | uniq -c | sort -nr | while read -r count room; do
    printf "%-10s: %d classes\n" "$room" "$count"
done

echo ""

# Total classes per day
echo "Total classes per day:"
tail -n +2 timetable.csv | cut -d',' -f1 | sort | uniq -c | while read -r count day; do
    printf "%-10s: %d classes\n" "$day" "$count"
done