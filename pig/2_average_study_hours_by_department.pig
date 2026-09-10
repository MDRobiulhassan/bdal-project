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
    Department,
    (double)Study_Hours AS Study_Hours;

grouped = GROUP typed BY Department;

result = FOREACH grouped GENERATE
    group AS Department,
    AVG(typed.Study_Hours) AS Average_Study_Hours;

STORE result
    INTO '/student_depression/pig2_output'
    USING PigStorage('|');