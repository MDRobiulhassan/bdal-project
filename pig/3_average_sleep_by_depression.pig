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
    (double)Sleep_Duration AS Sleep_Duration;

grouped = GROUP typed BY Depression;

result = FOREACH grouped GENERATE
    group AS Depression,
    AVG(typed.Sleep_Duration) AS Average_Sleep_Duration;

STORE result
    INTO '/student_depression/pig3_output'
    USING PigStorage('|');