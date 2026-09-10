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
    Depression,
    (double)CGPA AS CGPA;

grouped = GROUP typed BY Depression;

result = FOREACH grouped GENERATE
    group AS Depression,
    AVG(typed.CGPA) AS Average_CGPA;

STORE result
    INTO '/student_depression/pig4_output'
    USING PigStorage('|');