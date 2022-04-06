--45. Write a SQL query to print the result in the below format:

/*Problem Statement : A group of students participated in a course which has 4 subjects .
In order to complete the course,  students must fulfill below criteria :-
   * Student should score at least 40 marks in each subject 
   * Student  must secure at least 50% marks overall (Assuming total 100)
Assuming 100 marks as the maximum achievable marks for a given subject.*/

-------------------------------------------------------------------------
--Create Table Exam_Score
--(
--StudentId int,
--SubjectID int,
--Marks int
--)

--Insert Into Exam_Score values(101,1,60);
--Insert Into Exam_Score values(101,2,71);
--Insert Into Exam_Score values(101,3,65);
--Insert Into Exam_Score values(101,4,60);
--Insert Into Exam_Score values(102,1,40);
--Insert Into Exam_Score values(102,2,55);
--Insert Into Exam_Score values(102,3,64);
--Insert Into Exam_Score values(102,4,50);
--Insert Into Exam_Score values(103,1,45);
--Insert Into Exam_Score values(103,2,39);
--Insert Into Exam_Score values(103,3,60);
--Insert Into Exam_Score values(103,4,65);
--Insert Into Exam_Score values(104,1,83);
--Insert Into Exam_Score values(104,2,77);
--Insert Into Exam_Score values(104,3,91);
--Insert Into Exam_Score values(104,4,74);
--Insert Into Exam_Score values(105,1,83);
--Insert Into Exam_Score values(105,2,77);
--Insert Into Exam_Score values(105,4,74);

select * from Exam_Score
go 

Select StudentID,
SUM(CASE SubjectId when 1 then Marks else 0 END) as Subject1,
SUM(CASE SubjectId when 2 then Marks else 0 END)as Subject2,
SUM(CASE SubjectId when 3 then Marks else 0 END)as Subject3,
SUM(CASE SubjectId when 4 then Marks else 0 END) as Subject4,
SUM(Marks) as [Total Marks],
CASE WHEN MIN(Marks)>=40 and SUM(Marks)>=200 and count(marks)=4 then 'PASS' else 'FAIL' end as [Status]
From Exam_Score
GROUP BY StudentID