--31. SQL query to get the output as shown in the Output table (PIVOT)

--Create Table StudentInfo_1
--(
--StudentName Varchar(30),
--Subjects Varchar(30),
--Marks Bigint
--)

--insert into StudentInfo_1 Values ('David', 'English', 85)
--insert into StudentInfo_1 Values ('David', 'Maths', 90)
--insert into StudentInfo_1 Values ('David', 'Science', 88)
--insert into StudentInfo_1 Values ('John', 'English', 75)
--insert into StudentInfo_1 Values ('John', 'Maths', 85)
--insert into StudentInfo_1 Values ('John', 'Science', 80)
--insert into StudentInfo_1 Values ('Tom', 'English', 83)
--insert into StudentInfo_1 Values ('Tom', 'Maths', 80)
--insert into StudentInfo_1 Values ('Tom', 'Science', 92)


Select * from StudentInfo_1

--USING PIVOT TABLE
Select StudentName, English, Maths, Science
from 
	(
	Select * from StudentInfo_1
	) a
PIVOT 
	(
	MAX(Marks)
	for Subjects 
	in ([English],[Maths],[Science])

	) Pivotedtbl


select StudentName,
sum(case when Subjects= 'English' then Marks else 0 end) as English,
sum(case when Subjects= 'Maths' then Marks else 0 end) as Maths,
sum(case when Subjects= 'Science' then Marks else 0 end) as Science
from StudentInfo_1 group by StudentName order by StudentName;

--drop table StudentInfo_1