\# Student Lifestyle, Academic Performance and Mental Health Analysis



Big Data Analytics Lab project using \*\*Hadoop MapReduce\*\* and \*\*Apache Pig\*\* to analyze a dataset of 100,000 student lifestyle and academic records.



\## Project Overview



This project analyzes student lifestyle, academic performance, stress, sleep, study habits, and depression status using distributed data processing technologies. 



\### Technologies



\* \*\*Hadoop:\*\* 3.4.2

\* \*\*Apache Pig:\*\* 0.18.0

\* \*\*Java:\*\* 17 (System) / 1.8 (Hadoop Runtime)

\* \*\*Frameworks:\*\* Hadoop MapReduce, HDFS

\* \*\*OS:\*\* Windows 10

\* \*\*Data Verification:\*\* Python/Pandas



\## Dataset



\*\*Dataset:\*\* Student Depression \& Lifestyle (100k Data)  

\*\*Source:\*\* Kaggle



Dataset contains \*\*100,000 student records\*\* and \*\*11 attributes\*\*:



| Column | Description |

| :--- | :--- |

| \*\*Student\_ID\*\* | Unique student identifier |

| \*\*Age\*\* | Student age |

| \*\*Gender\*\* | Male/Female |

| \*\*Department\*\* | Student's academic department |

| \*\*CGPA\*\* | Cumulative GPA |

| \*\*Sleep\_Duration\*\* | Average sleep duration |

| \*\*Study\_Hours\*\* | Daily study hours |

| \*\*Social\_Media\_Hours\*\* | Daily social media usage |

| \*\*Physical\_Activity\*\* | Physical activity measure |

| \*\*Stress\_Level\*\* | Student stress level |

| \*\*Depression\*\* | Depression status |



\*\*Dataset validation confirmed:\*\*

\* 100,000 records across 11 columns

\* No missing or duplicate values

\* No duplicate Student IDs

\* Valid department/gender categories and numerical ranges

\* \*Note: The original dataset was not modified.\*



\## Project Structure



```text

Project/

│

├── student\_lifestyle\_100k.csv

│

├── mapreduce/

│   │

│   ├── MR1\_Average\_CGPA\_By\_Department/

│   │   ├── src/

│   │   │   ├── AverageCGPAMapper.java

│   │   │   ├── AverageCGPAReducer.java

│   │   │   └── AverageCGPADriver.java

│   │   ├── average-cgpa.jar

│   │   └── output.txt

│   │

│   ├── MR2\_Average\_Stress\_By\_Gender/

│   │   ├── src/

│   │   ├── average-stress.jar

│   │   └── output.txt

│   │

│   └── MR3\_Depression\_Count/

│       ├── src/

│       ├── depression-count.jar

│       └── output.txt

│

└── pig/

&#x20;   │

&#x20;   ├── 1\_top\_10\_students\_by\_cgpa.pig

&#x20;   ├── 2\_average\_study\_hours\_by\_department.pig

&#x20;   ├── 3\_average\_sleep\_by\_depression.pig

&#x20;   ├── 5\_top\_10\_students\_by\_study\_hours.pig

&#x20;   │

&#x20;   ├── Top10StudentsByCGPA.txt/

&#x20;   ├── AverageStudyHoursByDepartment.txt/

&#x20;   ├── AverageSleepByDepression.txt/

&#x20;   └── Top10StudentsByStudyHours.txt/

```



\## Environment Setup



\### Hadoop Configuration

Hadoop is installed at `C:\\hadoop`.

```cmd

hadoop version

```



\### Apache Pig Configuration

Pig is installed at `C:\\pig`.

```cmd

pig --version

```



\### Java Configuration

The system Java environment uses Java 17 (`OpenJDK 17.0.15`), but Hadoop's runtime strictly requires Java 8 (`C:\\JAVA\\jdk-1.8`). 



\*\*Do not change the global `JAVA\_HOME` just for Hadoop.\*\* Instead, set variables locally for Hadoop/Pig operations:

```cmd

set HADOOP\_HOME=C:\\hadoop

set JAVA=C:\\JAVA\\jdk-1.8\\bin\\java.exe

```



\## HDFS Dataset Setup



Create the HDFS directory and upload the dataset:



```cmd

hdfs dfs -mkdir -p /student\_depression

hdfs dfs -put -f "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\student\_lifestyle\_100k.csv" /student\_depression/

```



Verify the upload:

```cmd

hdfs dfs -ls /student\_depression

```

\*Expected Output:\* `/student\_depression/student\_lifestyle\_100k.csv`



\---



\## Part A: Hadoop MapReduce



\### MR1: Average CGPA by Department

\*\*Objective:\*\* Calculate the average CGPA for each academic department.



```cmd

hadoop jar "mapreduce\\average-cgpa.jar" AverageCGPADriver /student\_depression/student\_lifestyle\_100k.csv /student\_depression/mr1\_output

hdfs dfs -cat /student\_depression/mr1\_output/part-r-00000

```

\*Sample Result:\*

```text

Arts            2.902723272327235

Business        2.89767403314917

Engineering     2.8971351647803876

```



\### MR2: Average Stress Level by Gender

\*\*Objective:\*\* Calculate the average stress level for male and female students.



```cmd

hadoop jar "mapreduce\\average-stress.jar" AverageStressDriver /student\_depression/student\_lifestyle\_100k.csv /student\_depression/mr2\_output

hdfs dfs -cat /student\_depression/mr2\_output/part-r-00000

```



\### MR3: Number of Students by Depression Status

\*\*Objective:\*\* Count students according to their depression status.



```cmd

hadoop jar "mapreduce\\depression-count.jar" DepressionCountDriver /student\_depression/student\_lifestyle\_100k.csv /student\_depression/mr3\_output

hdfs dfs -cat /student\_depression/mr3\_output/part-r-00000

```



\---



\## Part B: Apache Pig



\*Note: All Pig outputs use `|` as the output delimiter.\*



\### Pig 1: Top 10 Students by CGPA

```cmd

hdfs dfs -rm -r /student\_depression/pig1\_output

pig "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\pig\\1\_top\_10\_students\_by\_cgpa.pig"

hdfs dfs -cat /student\_depression/pig1\_output/part-r-00000

```

Download result:

```cmd

hdfs dfs -get /student\_depression/pig1\_output "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\pig\\Top10StudentsByCGPA.txt"

```



\### Pig 2: Average Study Hours by Department

```cmd

hdfs dfs -rm -r /student\_depression/pig2\_output

pig "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\pig\\2\_average\_study\_hours\_by\_department.pig"

```



\### Pig 3: Average Sleep Duration by Depression Status

```cmd

hdfs dfs -rm -r /student\_depression/pig3\_output

pig "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\pig\\3\_average\_sleep\_by\_depression.pig"

```



\### Pig 5: Top 10 Students by Study Hours

```cmd

hdfs dfs -rm -r /student\_depression/pig5\_output

pig "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\pig\\5\_top\_10\_students\_by\_study\_hours.pig"

```



\### Important: Re-running Pig Jobs

Hadoop does not allow a job to write into an existing output directory. You must remove the old HDFS output first:

```cmd

hdfs dfs -rm -r /student\_depression/pig1\_output

```



\---



\## Important Pig Dependency Fix



During the initial Pig execution, a `ClassNotFoundException: org.apache.commons.collections.buffer.CircularFifoBuffer` error may occur. 



\*\*Fix:\*\* Copy the required dependency from Pig to Hadoop's common library:

```cmd

copy "C:\\pig\\lib\\hadoop3-runtime\\commons-collections-3.2.2.jar" "C:\\hadoop\\share\\hadoop\\common\\lib\\"

```

\*Note: Ensure both `commons-collections-3.2.2.jar` and `commons-collections4-4.4.jar` are retained in the directory.\*



\---



\## Complete Workflow



\### Startup Workflow

1\. \*\*Start HDFS \& YARN:\*\*

&#x20;  ```cmd

&#x20;  start-dfs.cmd

&#x20;  start-yarn.cmd

&#x20;  ```

2\. \*\*Verify Services\*\* (`NameNode`, `DataNode`, `ResourceManager`, `NodeManager`):

&#x20;  ```cmd

&#x20;  jps

&#x20;  ```

3\. \*\*Start the History Server\*\* (Required for Pig. Run in a separate CMD and keep open):

&#x20;  ```cmd

&#x20;  set HADOOP\_HOME=C:\\hadoop

&#x20;  set JAVA\_HOME=C:\\JAVA\\jdk-1.8

&#x20;  set CLASSPATH=C:\\hadoop\\share\\hadoop\\mapreduce\\\*;C:\\hadoop\\share\\hadoop\\mapreduce\\lib\\\*;C:\\hadoop\\share\\hadoop\\common\\\*;C:\\hadoop\\share\\hadoop\\common\\lib\\\*;C:\\hadoop\\share\\hadoop\\yarn\\\*;C:\\hadoop\\share\\hadoop\\yarn\\lib\\\*

&#x20;  C:\\JAVA\\jdk-1.8\\bin\\java.exe org.apache.hadoop.mapreduce.v2.hs.JobHistoryServer

&#x20;  ```



\### Shutdown Workflow

1\. Stop the History Server by pressing `Ctrl + C` in its dedicated CMD window.

2\. Stop YARN:

&#x20;  ```cmd

&#x20;  stop-yarn.cmd

&#x20;  ```

3\. Stop HDFS:

&#x20;  ```cmd

&#x20;  stop-dfs.cmd

&#x20;  ```



\## General Notes

\* Use `hadoop version`, not `hadoop --version`.

\* The History Server CMD must remain open while Pig jobs are running (uses Ports `10020` and `10033`).

\* HDFS output paths are directories, even when downloaded using names ending in `.txt`.

\* MapReduce results were independently verified against the dataset using Pandas.

\* Pig Job 4 (Average CGPA by Depression Status) is purposefully omitted from the current active workflow.



\## Project Summary



The project effectively demonstrates the use of Hadoop MapReduce and Apache Pig for processing and analyzing a 100,000-record student lifestyle dataset. 



\* \*\*MapReduce\*\* was successfully utilized to aggregate average CGPA by department, assess stress levels by gender, and count students by depression status. 

\* \*\*Apache Pig\*\* handled complex queries including sorting top students by CGPA/study hours, and calculating multi-variable averages like study hours by department and sleep duration by depression status. 



These operations validate proficiency in filtering, type conversion, grouping, aggregation, sorting, limiting, and overall distributed processing within the Hadoop ecosystem.

