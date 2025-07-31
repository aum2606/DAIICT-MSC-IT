#!/bin/bash

# Check if instructor name is provided
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 instructor_name"
    echo "Example: $0 NKS"
    exit 1
fi

instructor_name="$1"

# Check if timetable.csv exists
if [[ ! -f "timetable.csv" ]]; then
    echo "Error: timetable.csv not found!"
    exit 1
fi

# For testing purposes, you can hardcode the current day and time
# Uncomment and modify these lines for testing:
# current_day="Monday"
# current_time="10:30"

# Get current day and time
current_day=$(date +%A)
current_time=$(date +%H:%M)

echo "Finding location for instructor: $instructor_name"
echo "Current day: $current_day"
echo "Current time: $current_time"
echo "=================================="

# Function to check if current time falls within a time slot
time_in_slot() {
    local slot="$1"
    local current="$2"
    
    # Extract start and end times from slot (format: HH:MM-HH:MM)
    start_time=$(echo "$slot" | cut -d'-' -f1)
    end_time=$(echo "$slot" | cut -d'-' -f2)
    
    # Convert times to minutes for comparison
    current_minutes=$(echo "$current" | awk -F: '{print ($1 * 60) + $2}')
    start_minutes=$(echo "$start_time" | awk -F: '{print ($1 * 60) + $2}')
    end_minutes=$(echo "$end_time" | awk -F: '{print ($1 * 60) + $2}')
    
    # Check if current time is within the slot
    if [[ $current_minutes -ge $start_minutes && $current_minutes -lt $end_minutes ]]; then
        return 0  # true
    else
        return 1  # false
    fi
}

# Find if instructor has a class at current time
found_class=""
tail -n +2 timetable.csv | grep ",$instructor_name," | while IFS=',' read -r day time course instructor room; do
    if [[ "$day" == "$current_day" ]]; then
        if time_in_slot "$time" "$current_time"; then
            echo "🎯 FOUND: $instructor_name is currently in class!"
            echo "Location: $room"
            echo "Course: $course"
            echo "Time slot: $time"
            exit 0
        fi
    fi
done

# Check if the above loop found anything
if [[ $? -eq 0 ]]; then
    exit 0
fi

# If no class found, instructor is in office
echo "📍 $instructor_name is currently in office"
echo ""
echo "Next class schedule for $instructor_name:"
echo "========================================"

# Show next classes for today
next_classes=$(tail -n +2 timetable.csv | grep ",$instructor_name," | grep "^$current_day,")

if [[ -n "$next_classes" ]]; then
    echo "Today's remaining schedule:"
    echo "$next_classes" | while IFS=',' read -r day time course instructor room; do
        printf "%-12s %-10s %s\n" "$time" "$course" "$room"
    done
else
    echo "No more classes today for $instructor_name"
fi