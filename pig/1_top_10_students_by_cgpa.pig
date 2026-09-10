students = LOAD '/student_depression/student_lifestyle_100k.csv'
    USING PigStorage(',')
    AS (
        Student_ID:chararray,
        Age:chararray,
        Gender:chararray,
        Department:chararray,
        CGPA:chararray,
        Sleep_Duration:chararray,
        Study_Hours:chararray,
        Social_Media_Hours:chararray,
        Physical_Activity:chararray,
        Stress_Level:chararray,
        Depression:chararray
    );

data = FILTER students BY Student_ID != 'Student_ID';

typed = FOREACH data GENERATE
    Student_ID,
    Age,
    Gender,
    Department,
    (double)CGPA AS CGPA,
    Sleep_Duration,
    Study_Hours,
    Social_Media_Hours,
    Physical_Activity,
    Stress_Level,
    Depression;

sorted = ORDER typed BY CGPA DESC;

top_10 = LIMIT sorted 10;

STORE top_10
    INTO '/student_depression/pig1_output'
    USING PigStorage('|');