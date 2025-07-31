#!/bin/bash

# Check if student ID is provided
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 student_id"
    echo "Example: $0 202412001"
    exit 1
fi

student_id="$1"

# Check if timetable.csv exists
if [[ ! -f "timetable.csv" ]]; then
    echo "Error: timetable.csv not found!"
    exit 1
fi

# Extract batch from student ID (first 6 digits)
batch_id="${student_id:0:6}"

echo "Locating student: $student_id"
echo "Extracted batch: $batch_id"
echo "=========================="

# Create augmented timetable with batch IDs if it doesn't exist
if [[ ! -f "timetable_with_batches.csv" ]]; then
    echo "Creating augmented timetable with batch information..."
    
    # Create header for new CSV
    echo "Day,Time,Course,Instructor,Room,Batch" > timetable_with_batches.csv
    
    # Add batch information based on course patterns
    tail -n +2 timetable.csv | while IFS=',' read -r day time course instructor room; do
        # Simple batch assignment logic based on course codes
        # This is a basic example - you can enhance with actual mapping
        case "$course" in
            # First year courses (202412 batch)
            ED111|MC101|PH101|CH101) batch="202412" ;;
            # Second year courses (202411 batch)  
            ED211|MC201|CS201|EL201) batch="202411" ;;
            # Third year courses (202410 batch)
            MC311|CS301|EL301|EC301) batch="202410" ;;
            # Fourth year courses (202409 batch)
            MC401|CS401|EL401|EC401) batch="202409" ;;
            # Graduate courses (202408 batch)
            *5*|*6*) batch="202408" ;;
            # Default assignment based on course number
            *1*) batch="202412" ;;  # First year
            *2*) batch="202411" ;;  # Second year
            *3*) batch="202410" ;;  # Third year
            *4*) batch="202409" ;;  # Fourth year
            *) batch="202411" ;;    # Default to second year
        esac
        
        echo "$day,$time,$course,$instructor,$room,$batch"
    done >> timetable_with_batches.csv
    
    echo "Augmented timetable created!"
fi

# Get current day and time
current_day=$(date +%A)
current_time=$(date +%H:%M)

# For testing, you can uncomment and set these:
# current_day="Monday"
# current_time="10:30"

echo "Current day: $current_day"
echo "Current time: $current_time"
echo ""

# Function to check if current time falls within a time slot
time_in_slot() {
    local slot="$1"
    local current="$2"
    
    start_time=$(echo "$slot" | cut -d'-' -f1)
    end_time=$(echo "$slot" | cut -d'-' -f2)
    
    current_minutes=$(echo "$current" | awk -F: '{print ($1 * 60) + $2}')
    start_minutes=$(echo "$start_time" | awk -F: '{print ($1 * 60) + $2}')
    end_minutes=$(echo "$end_time" | awk -F: '{print ($1 * 60) + $2}')
    
    if [[ $current_minutes -ge $start_minutes && $current_minutes -lt $end_minutes ]]; then
        return 0
    else
        return 1
    fi
}

# Find student's current location
found_student=""
tail -n +2 timetable_with_batches.csv | grep ",$batch_id$" | while IFS=',' read -r day time course instructor room batch; do
    if [[ "$day" == "$current_day" ]]; then
        if time_in_slot "$time" "$current_time"; then
            echo "🎯 STUDENT LOCATED!"
            echo "=================="
            echo "Student ID: $student_id"
            echo "Batch: $batch_id"
            echo "Current Location: $room"
            echo "Course: $course"
            echo "Instructor: $instructor"
            echo "Time slot: $time"
            exit 0
        fi
    fi
done

# If the loop found the student, exit
if [[ $? -eq 0 ]]; then
    exit 0
fi

# If student not found in any current class
echo "🏠 Student not currently in class"
echo "================================="

# Show student's schedule for today
echo "Today's schedule for batch $batch_id:"
todays_schedule=$(tail -n +2 timetable_with_batches.csv | grep "^$current_day,.*,$batch_id$")

if [[ -n "$todays_schedule" ]]; then
    printf "%-12s %-10s %-10s %s\n" "Time" "Course" "Instructor" "Room"
    printf "%-12s %-10s %-10s %s\n" "----" "------" "----------" "----"
    echo "$todays_schedule" | while IFS=',' read -r day time course instructor room batch; do
        printf "%-12s %-10s %-10s %s\n" "$time" "$course" "$instructor" "$room"
    done
else
    echo "No classes scheduled today for batch $batch_id"
fi

echo ""
echo "Student is likely in:"
echo "- Library"
echo "- Cafeteria" 
echo "- Hostel"
echo "- Campus grounds"