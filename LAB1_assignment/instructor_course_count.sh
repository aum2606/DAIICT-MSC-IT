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

echo "Course count for instructor: $instructor_name"
echo "============================================"

# Get unique courses for the instructor
courses=$(tail -n +2 timetable.csv | grep ",$instructor_name," | cut -d',' -f3 | sort | uniq)

if [[ -z "$courses" ]]; then
    echo "No courses found for instructor: $instructor_name"
    exit 1
fi

# Count total number of unique courses
course_count=$(echo "$courses" | wc -l)

echo "Courses taught by $instructor_name:"
echo "$courses"
echo ""
echo "Total unique courses: $course_count"

# Also show total class sessions
total_sessions=$(tail -n +2 timetable.csv | grep -c ",$instructor_name,")
echo "Total class sessions: $total_sessions"