\# Student Lifestyle, Academic Performance and Mental Health Analysis



Big Data Analytics Lab project using \*\*Hadoop MapReduce\*\* and \*\*Apache Pig\*\* to analyze a dataset of 100,000 student lifestyle and academic records.



\## Project Overview



This project analyzes student lifestyle, academic performance, stress, sleep, study habits, and depression status using distributed data processing technologies.



\### Technologies



\* Hadoop 3.4.2

\* Apache Pig 0.18.0

\* Java 17

\* Hadoop MapReduce

\* HDFS

\* Windows 10

\* Python/Pandas for independent dataset verification



\## Dataset



\*\*Dataset:\*\* Student Depression \& Lifestyle (100k Data)



\*\*Source:\*\* Kaggle



Dataset contains \*\*100,000 student records\*\* and \*\*11 attributes\*\*:



| Column             | Description                   |

| ------------------ | ----------------------------- |

| Student\_ID         | Unique student identifier     |

| Age                | Student age                   |

| Gender             | Male/Female                   |

| Department         | Student's academic department |

| CGPA               | Cumulative GPA                |

| Sleep\_Duration     | Average sleep duration        |

| Study\_Hours        | Daily study hours             |

| Social\_Media\_Hours | Daily social media usage      |

| Physical\_Activity  | Physical activity measure     |

| Stress\_Level       | Student stress level          |

| Depression         | Depression status             |



Dataset validation confirmed:



\* 100,000 records

\* 11 columns

\* No missing values

\* No duplicate records

\* No duplicate Student IDs

\* Valid department and gender categories

\* Valid numerical ranges



The original dataset was not modified.



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



\### Hadoop



Hadoop is installed at:



```text

C:\\hadoop

```



Check Hadoop:



```cmd

hadoop version

```



Check Java:



```cmd

java --version

```



Expected Java version:



```text

OpenJDK 17.0.15

```



\### Apache Pig



Pig is installed at:



```text

C:\\pig

```



Check Pig:



```cmd

pig --version

```



Expected:



```text

Apache Pig version 0.18.0

```



\## Important Java Configuration



The system Java environment uses Java 17.



Hadoop's runtime uses:



```text

C:\\JAVA\\jdk-1.8

```



Do not change the global `JAVA\_HOME` just for Hadoop.



For Hadoop/Pig operations where the Hadoop Java 8 runtime is required:



```cmd

set HADOOP\_HOME=C:\\hadoop

set JAVA=C:\\JAVA\\jdk-1.8\\bin\\java.exe

```



\## Starting Hadoop



Open a CMD window and run:



```cmd

start-dfs.cmd

start-yarn.cmd

```



Check the running services:



```cmd

jps

```



Expected services:



```text

NameNode

DataNode

ResourceManager

NodeManager

```



\## Starting the MapReduce History Server



The History Server is required for Apache Pig jobs.



Open a \*\*separate CMD window\*\* and run:



```cmd

set HADOOP\_HOME=C:\\hadoop

set JAVA\_HOME=C:\\JAVA\\jdk-1.8

set CLASSPATH=C:\\hadoop\\share\\hadoop\\mapreduce\\\*;C:\\hadoop\\share\\hadoop\\mapreduce\\lib\\\*;C:\\hadoop\\share\\hadoop\\common\\\*;C:\\hadoop\\share\\hadoop\\common\\lib\\\*;C:\\hadoop\\share\\hadoop\\yarn\\\*;C:\\hadoop\\share\\hadoop\\yarn\\lib\\\*

C:\\JAVA\\jdk-1.8\\bin\\java.exe org.apache.hadoop.mapreduce.v2.hs.JobHistoryServer

```



Keep this CMD window open while running Pig jobs.



The History Server uses:



```text

Port 10020

Port 10033

```



\## Stopping Hadoop



Stop YARN:



```cmd

stop-yarn.cmd

```



Stop HDFS:



```cmd

stop-dfs.cmd

```



Stop the History Server by pressing:



```text

Ctrl + C

```



in its CMD window.



\## HDFS Dataset Setup



Create the HDFS directory:



```cmd

hdfs dfs -mkdir -p /student\_depression

```



Upload the dataset:



```cmd

hdfs dfs -put -f "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\student\_lifestyle\_100k.csv" /student\_depression/

```



Verify:



```cmd

hdfs dfs -ls /student\_depression

```



The dataset should appear as:



```text

/student\_depression/student\_lifestyle\_100k.csv

```



\## Part A: Hadoop MapReduce



Three MapReduce jobs were implemented.



\### MR1: Average CGPA by Department



\*\*Objective:\*\* Calculate the average CGPA for each academic department.



Run:



```cmd

hadoop jar "mapreduce\\average-cgpa.jar" AverageCGPADriver /student\_depression/student\_lifestyle\_100k.csv /student\_depression/mr1\_output

```



View output:



```cmd

hdfs dfs -cat /student\_depression/mr1\_output/part-r-00000

```



Result:



```text

Arts            2.902723272327235

Business        2.89767403314917

Engineering     2.8971351647803876

Medical         2.896051893408144

Science         2.897992127945791

```



\### MR2: Average Stress Level by Gender



\*\*Objective:\*\* Calculate the average stress level for male and female students.



Run:



```cmd

hadoop jar "mapreduce\\average-stress.jar" AverageStressDriver /student\_depression/student\_lifestyle\_100k.csv /student\_depression/mr2\_output

```



View output:



```cmd

hdfs dfs -cat /student\_depression/mr2\_output/part-r-00000

```



Result:



```text

Female  4.130012028869286

Male    4.13330007980846

```



\### MR3: Number of Students by Depression Status



\*\*Objective:\*\* Count students according to their depression status.



Run:



```cmd

hadoop jar "mapreduce\\depression-count.jar" DepressionCountDriver /student\_depression/student\_lifestyle\_100k.csv /student\_depression/mr3\_output

```



View output:



```cmd

hdfs dfs -cat /student\_depression/mr3\_output/part-r-00000

```



Result:



```text

False   89938

True    10062

```



Total:



```text

100000 students

```



\## Part B: Apache Pig



The Pig scripts use the CSV dataset stored in HDFS.



All Pig outputs use:



```text

|

```



as the output delimiter.



\### Pig 1: Top 10 Students by CGPA



\*\*Script:\*\*



```text

pig/1\_top\_10\_students\_by\_cgpa.pig

```



Run:



```cmd

hdfs dfs -rm -r /student\_depression/pig1\_output

pig "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\pig\\1\_top\_10\_students\_by\_cgpa.pig"

```



View:



```cmd

hdfs dfs -cat /student\_depression/pig1\_output/part-r-00000

```



The result contains the 10 students with the highest CGPA.



Example:



```text

7549|20|Male|Business|4.0|8.6|7.6|2.4|29|6|False

52867|19|Female|Arts|4.0|8.2|7.1|4.9|90|2|False

...

```



All top 10 students have a CGPA of `4.0`.



Download the result:



```cmd

hdfs dfs -get /student\_depression/pig1\_output "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\pig\\Top10StudentsByCGPA.txt"

```



\### Pig 2: Average Study Hours by Department



\*\*Script:\*\*



```text

pig/2\_average\_study\_hours\_by\_department.pig

```



Run:



```cmd

hdfs dfs -rm -r /student\_depression/pig2\_output

pig "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\pig\\2\_average\_study\_hours\_by\_department.pig"

```



View:



```cmd

hdfs dfs -cat /student\_depression/pig2\_output/part-r-00000

```



Download:



```cmd

hdfs dfs -get /student\_depression/pig2\_output "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\pig\\AverageStudyHoursByDepartment.txt"

```



\### Pig 3: Average Sleep Duration by Depression Status



\*\*Script:\*\*



```text

pig/3\_average\_sleep\_by\_depression.pig

```



Run:



```cmd

hdfs dfs -rm -r /student\_depression/pig3\_output

pig "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\pig\\3\_average\_sleep\_by\_depression.pig"

```



View:



```cmd

hdfs dfs -cat /student\_depression/pig3\_output/part-r-00000

```



Download:



```cmd

hdfs dfs -get /student\_depression/pig3\_output "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\pig\\AverageSleepByDepression.txt"

```



\### Pig 5: Top 10 Students by Study Hours



\*\*Script:\*\*



```text

pig/5\_top\_10\_students\_by\_study\_hours.pig

```



Run:



```cmd

hdfs dfs -rm -r /student\_depression/pig5\_output

pig "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\pig\\5\_top\_10\_students\_by\_study\_hours.pig"

```



View:



```cmd

hdfs dfs -cat /student\_depression/pig5\_output/part-r-00000

```



Download:



```cmd

hdfs dfs -get /student\_depression/pig5\_output "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\pig\\Top10StudentsByStudyHours.txt"

```



\## Downloaded Pig Output Structure



After downloading the results, the `pig` directory contains Hadoop output directories with `.txt` names:



```text

pig/

│

├── Top10StudentsByCGPA.txt/

│   ├── part-r-00000

│   └── \_SUCCESS

│

├── AverageStudyHoursByDepartment.txt/

│   ├── part-r-00000

│   └── \_SUCCESS

│

├── AverageSleepByDepression.txt/

│   ├── part-r-00000

│   └── \_SUCCESS

│

└── Top10StudentsByStudyHours.txt/

&#x20;   ├── part-r-00000

&#x20;   └── \_SUCCESS

```



To view a downloaded result:



```cmd

type "D:\\website\\Varsity Notes\\8th Semester\\BDAL\\Project\\pig\\Top10StudentsByCGPA.txt\\part-r-00000"

```



Replace the directory name for the other outputs.



\## Re-running a Pig Job



Hadoop does not allow a job to write into an existing output directory.



Therefore, remove the old HDFS output first:



```cmd

hdfs dfs -rm -r /student\_depression/pig1\_output

```



Then run the Pig script again.



The same pattern applies to:



```text

/student\_depression/pig2\_output

/student\_depression/pig3\_output

/student\_depression/pig5\_output

```



\## Important Pig Dependency Fix



During the initial Pig execution, the following error occurred:



```text

ClassNotFoundException:

org.apache.commons.collections.buffer.CircularFifoBuffer

```



The required dependency was found in:



```text

C:\\pig\\lib\\hadoop3-runtime\\commons-collections-3.2.2.jar

```



It was copied into Hadoop's common library:



```cmd

copy "C:\\pig\\lib\\hadoop3-runtime\\commons-collections-3.2.2.jar" "C:\\hadoop\\share\\hadoop\\common\\lib\\"

```



The Hadoop common library now contains both:



```text

commons-collections-3.2.2.jar

commons-collections4-4.4.jar

```



Both should be retained.



\## Complete Startup Workflow



For a new lab session:



\### 1. Start HDFS



```cmd

start-dfs.cmd

```



\### 2. Start YARN



```cmd

start-yarn.cmd

```



\### 3. Verify



```cmd

jps

```



\### 4. Start the History Server



Open another CMD:



```cmd

set HADOOP\_HOME=C:\\hadoop

set JAVA\_HOME=C:\\JAVA\\jdk-1.8

set CLASSPATH=C:\\hadoop\\share\\hadoop\\mapreduce\\\*;C:\\hadoop\\share\\hadoop\\mapreduce\\lib\\\*;C:\\hadoop\\share\\hadoop\\common\\\*;C:\\hadoop\\share\\hadoop\\common\\lib\\\*;C:\\hadoop\\share\\hadoop\\yarn\\\*;C:\\hadoop\\share\\hadoop\\yarn\\lib\\\*

C:\\JAVA\\jdk-1.8\\bin\\java.exe org.apache.hadoop.mapreduce.v2.hs.JobHistoryServer

```



\### 5. Verify Dataset



```cmd

hdfs dfs -ls /student\_depression

```



\### 6. Run MapReduce or Pig Jobs



Use the commands described above.



\## Complete Shutdown Workflow



Stop the History Server:



```text

Ctrl + C

```



Then stop YARN:



```cmd

stop-yarn.cmd

```



Then stop HDFS:



```cmd

stop-dfs.cmd

```



\## Notes



\* `hadoop --version` should not be used in this setup. Use:



```cmd

hadoop version

```



\* `pig --version` can be used to check the Pig installation.

\* `java --version` shows the system Java version.

\* The History Server CMD must remain open while Pig jobs are running.

\* HDFS output paths are directories, even when downloaded using names ending in `.txt`.

\* Pig output uses `|` as the delimiter.

\* The original dataset remains unchanged.

\* MapReduce results were independently verified against the dataset.

\* Pig Job 4 (`Average CGPA by Depression Status`) is not included in the current workflow.



\## Project Summary



The project demonstrates the use of Hadoop MapReduce and Apache Pig for processing and analyzing a 100,000-record student lifestyle dataset.



The MapReduce implementation focuses on:



1\. Average CGPA by department

2\. Average stress level by gender

3\. Student count by depression status



The Pig implementation focuses on:



1\. Top 10 students by CGPA

2\. Average study hours by department

3\. Average sleep duration by depression status

4\. Top 10 students by study hours



These operations demonstrate filtering, type conversion, grouping, aggregation, sorting, limiting, and distributed processing using Hadoop and Pig.



