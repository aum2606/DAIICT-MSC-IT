# Marauder's Map for DAIICT 🗺️

A shell scripting project inspired by the magical Marauder's Map from Harry Potter, designed to help locate students, instructors, and track schedules at DA-IICT.

## 📋 Prerequisites

- Bash shell
- `timetable.csv` file in the same directory
- Basic Unix commands: `cat`, `grep`, `cut`, `sort`, `uniq`, `date`

## 🚀 Scripts Overview

### Basic Operations

#### 1. Today's Schedule (`todays_schedule.sh`)
Displays the complete schedule for the current day.

```bash
chmod +x todays_schedule.sh
./todays_schedule.sh
```

**Sample Output:**
```
Today's Schedule for Monday:
==================================
08:00-08:50     ED111      NKS        CEP-204 
09:00-09:50     SC223      MKR        CEP-110 
10:00-10:50     MC213      SP         CEP-105 
```

#### 2. Instructor Course Count (`instructor_course_count.sh`)
Counts the number of courses an instructor is teaching.

```bash
chmod +x instructor_course_count.sh
./instructor_course_count.sh NKS
```

**Sample Output:**
```
Course count for instructor: NKS
============================================
Courses taught by NKS:
ED111
MC213
SC301

Total unique courses: 3
Total class sessions: 15
```

#### 3. Room Course List (`room_course_list.sh`)
Lists all courses held in a specific room.

```bash
chmod +x room_course_list.sh
./room_course_list.sh CEP-204
```

#### 4. Course Timetable (`course_timetable.sh`)
Extracts the complete timetable for a specific course.

```bash
chmod +x course_timetable.sh
./course_timetable.sh SC223
```

### Intermediate Operations

#### 5. Room Empty Slots (`room_empty_slots.sh`)
Finds when a room is empty during the week.

```bash
chmod +x room_empty_slots.sh
./room_empty_slots.sh CEP-207
```

**Sample Output:**
```
Empty slots for room: CEP-207
=================================
Empty slots:
============
Monday     08:00-08:50
Monday     12:00-12:50
Tuesday    09:00-09:50
...

Summary for CEP-207:
======================
Total possible slots: 65
Occupied slots: 23
Empty slots: 42
```

#### 6. Room Class Count (`room_class_count.sh`)
Counts classes held in each room for each day.

```bash
chmod +x room_class_count.sh
./room_class_count.sh
```

**Sample Output:**
```
Classes count per room per day
==============================
Room, Day, Count
CEP-103, Friday, 4
CEP-103, Monday, 5
CEP-103, Thursday, 4
CEP-103, Tuesday, 3
CEP-103, Wednesday, 4
```

#### 7. Instructor Location (`instructor_location.sh`)
Finds where an instructor is at the current time.

```bash
chmod +x instructor_location.sh
./instructor_location.sh NKS
```

**Sample Output:**
```
Finding location for instructor: NKS
Current day: Monday
Current time: 10:30
==================================
🎯 FOUND: NKS is currently in class!
Location: CEP-204
Course: ED111
Time slot: 10:00-10:50
```

### Advanced Operations

#### 8. Student Locator (`student_locator.sh`)
Locates a student in real-time based on their student ID and batch.

```bash
chmod +x student_locator.sh
./student_locator.sh 202412001
```

**Features:**
- Automatically creates `timetable_with_batches.csv` with batch information
- Maps courses to batches using intelligent logic
- Provides current location or likely whereabouts

## 🔧 Installation & Setup

1. **Clone or download all scripts**
2. **Ensure `timetable.csv` is in the same directory**
3. **Make scripts executable:**
   ```bash
   chmod +x *.sh
   ```

## 📊 Data Format

The `timetable.csv` should have the following format:
```csv
Day,Time,Course,Instructor,Room
Monday,08:00-08:50,ED111,NKS,CEP-204
Monday,08:00-08:50,SC223,MKR,CEP-110
...
```

## 🎯 Key Features

- **Real-time location tracking** for instructors and students
- **Intelligent batch mapping** based on course codes
- **Empty slot detection** for room utilization
- **Comprehensive statistics** and summaries
- **User-friendly output** with emojis and formatting

## 🧪 Testing

For testing the time-dependent scripts (`instructor_location.sh` and `student_locator.sh`), you can hardcode the current day and time by uncommenting and modifying these lines in the scripts:

```bash
# current_day="Monday"
# current_time="10:30"
```

## 🔮 Future Enhancements

- **Graphical map integration** - Plot locations on actual campus map
- **Web interface** - Browser-based Marauder's Map
- **Real-time updates** - Integration with college management system
- **Mobile app** - Campus navigation and location sharing
- **Historical tracking** - Analytics on room utilization and patterns

## 🎓 Learning Outcomes

This project demonstrates:
- Advanced shell scripting techniques
- File processing with CSV data
- Time-based logic and calculations
- Pattern matching and text processing
- Data augmentation and mapping
- Real-world application development

## 🐛 Troubleshooting

**Common Issues:**

1. **Permission denied**: Run `chmod +x script_name.sh`
2. **File not found**: Ensure `timetable.csv` is in the current directory
3. **No results**: Check if instructor/room/course names match exactly (case-sensitive)
4. **Time issues**: Verify system date/time or use hardcoded values for testing

## 📝 Notes

- All scripts are case-sensitive for instructor names, room names, and course codes
- Time format should be HH:MM-HH:MM (24-hour format)
- Day names should be full names (Monday, Tuesday, etc.)
- The student locator creates an augmented CSV file automatically

---

*"I solemnly swear that I am up to no good!"* 🪄

**Mischief Managed!** ✨