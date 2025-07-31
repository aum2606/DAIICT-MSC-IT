#!/bin/bash

# Check if course name is provided
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 course_name"
    echo "Example: $0 SC223"
    exit 1
fi

course_name="$1"

# Check if timetable.csv exists
if [[ ! -f "timetable.csv" ]]; then
    echo "Error: timetable.csv not found!"
    exit 1
fi

echo "Timetable for course: $course_name"
echo "=================================="

# Get all entries for the specified course
course_entries=$(tail -n +2 timetable.csv | grep ",$course_name,")

if [[ -z "$course_entries" ]]; then
    echo "No timetable found for course: $course_name"
    exit 1
fi

# Display header
printf "%-10s %-12s %-10s %-10s\n" "Day" "Time" "Instructor" "Room"
printf "%-10s %-12s %-10s %-10s\n" "---" "----" "----------" "----"

# Display all entries for the course
echo "$course_entries" | while IFS=',' read -r day time course instructor room; do
    printf "%-10s %-12s %-10s %-10s\n" "$day" "$time" "$instructor" "$room"
done | sort -k1,1 -k2,2

# Show course statistics
echo ""
echo "Course Statistics:"
echo "=================="
total_sessions=$(echo "$course_entries" | wc -l)
unique_instructors=$(echo "$course_entries" | cut -d',' -f4 | sort | uniq | wc -l)
unique_rooms=$(echo "$course_entries" | cut -d',' -f5 | sort | uniq | wc -l)

echo "Total sessions: $total_sessions"
echo "Unique instructors: $unique_instructors"
echo "Unique rooms: $unique_rooms"