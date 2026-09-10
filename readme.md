# Student Lifestyle, Academic Performance and Mental Health Analysis

A **Big Data Analytics Lab** project using **Hadoop MapReduce** and **Apache Pig** to analyze a dataset of 100,000 student lifestyle and academic records.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Technologies](#technologies)
- [Dataset](#dataset)
- [Project Structure](#project-structure)
- [Environment Setup](#environment-setup)
- [HDFS Dataset Setup](#hdfs-dataset-setup)
- [Part A: Hadoop MapReduce](#part-a-hadoop-mapreduce)
- [Part B: Apache Pig](#part-b-apache-pig)
- [Pig Dependency Fix](#important-pig-dependency-fix)
- [Complete Workflow](#complete-workflow)
- [General Notes](#general-notes)
- [Project Summary](#project-summary)

---

## Project Overview

This project analyzes student lifestyle, academic performance, stress, sleep, study habits, and depression status using distributed data processing technologies.

### Technologies

| Component | Version / Detail |
| :--- | :--- |
| Hadoop | 3.4.2 |
| Apache Pig | 0.18.0 |
| Java | 17 (System) / 1.8 (Hadoop Runtime) |
| Frameworks | Hadoop MapReduce, HDFS |
| OS | Windows 10 |
| Data Verification | Python / Pandas |

---

## Dataset

**Dataset:** Student Depression & Lifestyle (100k Data)
**Source:** Kaggle

The dataset contains **100,000 student records** across **11 attributes**:

| Column | Description |
| :--- | :--- |
| `Student_ID` | Unique student identifier |
| `Age` | Student age |
| `Gender` | Male / Female |
| `Department` | Student's academic department |
| `CGPA` | Cumulative GPA |
| `Sleep_Duration` | Average sleep duration |
| `Study_Hours` | Daily study hours |
| `Social_Media_Hours` | Daily social media usage |
| `Physical_Activity` | Physical activity measure |
| `Stress_Level` | Student stress level |
| `Depression` | Depression status |

**Dataset validation confirmed:**
- 100,000 records across 11 columns
- No missing or duplicate values
- No duplicate Student IDs
- Valid department/gender categories and numerical ranges

> **Note:** The original dataset was not modified.

---

## Project Structure

```text
Project/
│
├── student_lifestyle_100k.csv
│
├── mapreduce/
│   │
│   ├── MR1_Average_CGPA_By_Department/
│   │   ├── src/
│   │   │   ├── AverageCGPAMapper.java
│   │   │   ├── AverageCGPAReducer.java
│   │   │   └── AverageCGPADriver.java
│   │   ├── average-cgpa.jar
│   │   └── output.txt
│   │
│   ├── MR2_Average_Stress_By_Gender/
│   │   ├── src/
│   │   ├── average-stress.jar
│   │   └── output.txt
│   │
│   └── MR3_Depression_Count/
│       ├── src/
│       ├── depression-count.jar
│       └── output.txt
│
└── pig/
    │
    ├── 1_top_10_students_by_cgpa.pig
    ├── 2_average_study_hours_by_department.pig
    ├── 3_average_sleep_by_depression.pig
    ├── 5_top_10_students_by_study_hours.pig
    │
    ├── Top10StudentsByCGPA.txt/
    ├── AverageStudyHoursByDepartment.txt/
    ├── AverageSleepByDepression.txt/
    └── Top10StudentsByStudyHours.txt/
```

---

## Environment Setup

### Hadoop Configuration

Hadoop is installed at `C:\hadoop`.

```cmd
hadoop version
```

### Apache Pig Configuration

Pig is installed at `C:\pig`.

```cmd
pig --version
```

### Java Configuration

The system Java environment uses Java 17 (`OpenJDK 17.0.15`), but Hadoop's runtime strictly requires Java 8 (`C:\JAVA\jdk-1.8`).

**Do not change the global `JAVA_HOME` just for Hadoop.** Instead, set variables locally for Hadoop/Pig operations:

```cmd
set HADOOP_HOME=C:\hadoop
set JAVA=C:\JAVA\jdk-1.8\bin\java.exe
```

---

## HDFS Dataset Setup

Create the HDFS directory and upload the dataset:

```cmd
hdfs dfs -mkdir -p /student_depression
hdfs dfs -put -f "D:\website\Varsity Notes\8th Semester\BDAL\Project\student_lifestyle_100k.csv" /student_depression/
```

Verify the upload:

```cmd
hdfs dfs -ls /student_depression
```

*Expected output:* `/student_depression/student_lifestyle_100k.csv`

---

## Part A: Hadoop MapReduce

### MR1: Average CGPA by Department

**Objective:** Calculate the average CGPA for each academic department.

```cmd
hadoop jar "mapreduce\average-cgpa.jar" AverageCGPADriver /student_depression/student_lifestyle_100k.csv /student_depression/mr1_output
hdfs dfs -cat /student_depression/mr1_output/part-r-00000
```

*Sample result:*

```text
Arts            2.902723272327235
Business        2.89767403314917
Engineering     2.8971351647803876
```

### MR2: Average Stress Level by Gender

**Objective:** Calculate the average stress level for male and female students.

```cmd
hadoop jar "mapreduce\average-stress.jar" AverageStressDriver /student_depression/student_lifestyle_100k.csv /student_depression/mr2_output
hdfs dfs -cat /student_depression/mr2_output/part-r-00000
```

### MR3: Number of Students by Depression Status

**Objective:** Count students according to their depression status.

```cmd
hadoop jar "mapreduce\depression-count.jar" DepressionCountDriver /student_depression/student_lifestyle_100k.csv /student_depression/mr3_output
hdfs dfs -cat /student_depression/mr3_output/part-r-00000
```

---

## Part B: Apache Pig

> All Pig outputs use `|` as the field delimiter.

### Pig 1: Top 10 Students by CGPA

```cmd
hdfs dfs -rm -r /student_depression/pig1_output
pig "D:\website\Varsity Notes\8th Semester\BDAL\Project\pig\1_top_10_students_by_cgpa.pig"
hdfs dfs -cat /student_depression/pig1_output/part-r-00000
```

Download result:

```cmd
hdfs dfs -get /student_depression/pig1_output "D:\website\Varsity Notes\8th Semester\BDAL\Project\pig\Top10StudentsByCGPA.txt"
```

### Pig 2: Average Study Hours by Department

```cmd
hdfs dfs -rm -r /student_depression/pig2_output
pig "D:\website\Varsity Notes\8th Semester\BDAL\Project\pig\2_average_study_hours_by_department.pig"
```

### Pig 3: Average Sleep Duration by Depression Status

```cmd
hdfs dfs -rm -r /student_depression/pig3_output
pig "D:\website\Varsity Notes\8th Semester\BDAL\Project\pig\3_average_sleep_by_depression.pig"
```

### Pig 5: Top 10 Students by Study Hours

```cmd
hdfs dfs -rm -r /student_depression/pig5_output
pig "D:\website\Varsity Notes\8th Semester\BDAL\Project\pig\5_top_10_students_by_study_hours.pig"
```

### Re-running Pig Jobs

Hadoop does not allow a job to write into an existing output directory. You must remove the old HDFS output first:

```cmd
hdfs dfs -rm -r /student_depression/pig1_output
```

---

## Important Pig Dependency Fix

During the initial Pig execution, a `ClassNotFoundException: org.apache.commons.collections.buffer.CircularFifoBuffer` error may occur.

**Fix:** Copy the required dependency from Pig to Hadoop's common library:

```cmd
copy "C:\pig\lib\hadoop3-runtime\commons-collections-3.2.2.jar" "C:\hadoop\share\hadoop\common\lib\"
```

> **Note:** Ensure both `commons-collections-3.2.2.jar` and `commons-collections4-4.4.jar` are retained in the directory.

---

## Complete Workflow

### Startup Workflow

1. **Start HDFS & YARN:**

   ```cmd
   start-dfs.cmd
   start-yarn.cmd
   ```

2. **Verify services** (`NameNode`, `DataNode`, `ResourceManager`, `NodeManager`):

   ```cmd
   jps
   ```

3. **Start the History Server** (required for Pig — run in a separate CMD window and keep it open):

   ```cmd
   set HADOOP_HOME=C:\hadoop
   set JAVA_HOME=C:\JAVA\jdk-1.8
   set CLASSPATH=C:\hadoop\share\hadoop\mapreduce\*;C:\hadoop\share\hadoop\mapreduce\lib\*;C:\hadoop\share\hadoop\common\*;C:\hadoop\share\hadoop\common\lib\*;C:\hadoop\share\hadoop\yarn\*;C:\hadoop\share\hadoop\yarn\lib\*
   C:\JAVA\jdk-1.8\bin\java.exe org.apache.hadoop.mapreduce.v2.hs.JobHistoryServer
   ```

### Shutdown Workflow

1. Stop the History Server by pressing `Ctrl + C` in its dedicated CMD window.
2. Stop YARN:

   ```cmd
   stop-yarn.cmd
   ```

3. Stop HDFS:

   ```cmd
   stop-dfs.cmd
   ```

---

## General Notes

- Use `hadoop version`, not `hadoop --version`.
- The History Server CMD window must remain open while Pig jobs are running (uses ports `10020` and `10033`).
- HDFS output paths are directories, even when downloaded using names ending in `.txt`.
- MapReduce results were independently verified against the dataset using Pandas.
- Pig Job 4 (Average CGPA by Depression Status) is purposefully omitted from the current active workflow.

---

## Project Summary

This project demonstrates the use of Hadoop MapReduce and Apache Pig for processing and analyzing a 100,000-record student lifestyle dataset.

- **MapReduce** was used to aggregate average CGPA by department, assess stress levels by gender, and count students by depression status.
- **Apache Pig** handled complex queries including sorting top students by CGPA/study hours, and calculating multi-variable averages such as study hours by department and sleep duration by depression status.

These operations demonstrate proficiency in filtering, type conversion, grouping, aggregation, sorting, limiting, and overall distributed processing within the Hadoop ecosystem.
