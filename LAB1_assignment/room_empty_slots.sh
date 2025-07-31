#!/bin/bash

# Check if room name is provided
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 room_name"
    echo "Example: $0 CEP-207"
    exit 1
fi

room_name="$1"

# Check if timetable.csv exists
if [[ ! -f "timetable.csv" ]]; then
    echo "Error: timetable.csv not found!"
    exit 1
fi

echo "Empty slots for room: $room_name"
echo "================================="

# Get all possible time slots and days
all_times=$(tail -n +2 timetable.csv | cut -d',' -f2 | sort | uniq)
all_days=("Monday" "Tuesday" "Wednesday" "Thursday" "Friday")

# Get occupied slots for the room
occupied_slots=$(tail -n +2 timetable.csv | grep ",$room_name$" | cut -d',' -f1,2 | sort)

echo "Occupied slots:"
echo "$occupied_slots" | while IFS=',' read -r day time; do
    printf "%-10s %s\n" "$day" "$time"
done

echo ""
echo "Empty slots:"
echo "============"

# Check each day and time combination
for day in "${all_days[@]}"; do
    echo "$all_times" | while read -r time; do
        # Check if this day-time combination is occupied
        if ! echo "$occupied_slots" | grep -q "^$day,$time$"; then
            printf "%-10s %s\n" "$day" "$time"
        fi
    done
done | sort -k1,1 -k2,2

# Count empty vs occupied slots
total_possible=$(echo "$all_times" | wc -l)
total_possible=$((total_possible * 5))  # 5 days
occupied_count=$(echo "$occupied_slots" | wc -l)
empty_count=$((total_possible - occupied_count))

echo ""
echo "Summary for $room_name:"
echo "======================"
echo "Total possible slots: $total_possible"
echo "Occupied slots: $occupied_count"
echo "Empty slots: $empty_count"