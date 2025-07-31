#!/bin/bash

# Check if room name is provided
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 room_name"
    echo "Example: $0 CEP-204"
    exit 1
fi

room_name="$1"

# Check if timetable.csv exists
if [[ ! -f "timetable.csv" ]]; then
    echo "Error: timetable.csv not found!"
    exit 1
fi

echo "Courses held in room: $room_name"
echo "================================="

# Get all entries for the specified room
room_entries=$(tail -n +2 timetable.csv | grep ",$room_name$")

if [[ -z "$room_entries" ]]; then
    echo "No courses found in room: $room_name"
    exit 1
fi

# Display header
printf "%-10s %-12s %-15s %-10s\n" "Day" "Time" "Course" "Instructor"
printf "%-10s %-12s %-15s %-10s\n" "---" "----" "-------" "----------"

# Display all courses in the room
echo "$room_entries" | while IFS=',' read -r day time course instructor room; do
    printf "%-10s %-12s %-15s %-10s\n" "$day" "$time" "$course" "$instructor"
done | sort -k1,1 -k2,2

# Show unique courses
echo ""
echo "Unique courses in $room_name:"
echo "$room_entries" | cut -d',' -f3 | sort | uniq